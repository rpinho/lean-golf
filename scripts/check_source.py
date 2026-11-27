"""Source preparation, process limits and public JSON protocol for golfcheck."""

import contextlib
import hashlib
import json
import os
from pathlib import Path
import re
import resource
import select
import signal
import stat
import subprocess
import sys
import tempfile
import time


MAX_SOURCE_BYTES = 64 * 1024
MAX_ELAPSED_SECONDS = 120
LEAN_MEMORY_MIB = 2048
MAX_ADDRESS_SPACE = 4 * 1024**3
MAX_DIAGNOSTIC_BYTES = 4096
MAX_RESULT_BYTES = 1024**2
CHAR_LITERAL = re.compile(r"'(?:[^'\\\n\r]|\\(?:x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|.))'")


class Rejected(Exception):
    pass


def read_source(path):
    fd = os.open(path, os.O_RDONLY | os.O_NONBLOCK)
    with os.fdopen(fd, "rb") as source:
        if not stat.S_ISREG(os.fstat(source.fileno()).st_mode):
            raise Rejected("submission must be a regular file")
        raw = source.read(MAX_SOURCE_BYTES + 1)
    if len(raw) > MAX_SOURCE_BYTES:
        raise Rejected("submission exceeds 64 KB (65536 bytes)")
    try:
        return raw, raw.decode("utf-8")
    except UnicodeDecodeError as error:
        raise Rejected("submission is not valid UTF-8") from error


def strip_comments(text):
    """Return the source to parse and compile, keeping newlines and token boundaries."""
    text = text.replace("\r\n", "\n")
    parts = []
    pos = 0
    while pos < len(text):
        if text.startswith("--", pos):
            end = text.find("\n", pos + 2)
            pos = len(text) if end < 0 else end
        elif text.startswith("/-", pos):
            start = pos
            pos += 2
            depth = 1
            while pos < len(text) and depth:
                if text.startswith("/-", pos):
                    depth += 1
                    pos += 2
                elif text.startswith("-/", pos):
                    depth -= 1
                    pos += 2
                else:
                    pos += 1
            if depth:
                raise Rejected("source lint: unterminated block comment")
            parts.append("".join(c if c == "\n" else " " for c in text[start:pos]))
        else:
            char = text[pos]
            previous = text[pos - 1] if pos else " "
            if char == "'" and not (previous.isalnum() or previous in "_'"):
                literal = CHAR_LITERAL.match(text, pos)
                if literal:
                    parts.append(literal[0])
                    pos = literal.end()
                    continue
            if char == '"':
                raise Rejected("source lint: string literals are forbidden")
            if char in "«»":
                raise Rejected("source lint: quoted identifiers are forbidden")
            if char == "\x00":
                raise Rejected("source lint: NUL bytes are forbidden")
            parts.append(char)
            pos += 1
    return "".join(parts)


def score_v1(proof):
    """Count non-whitespace Unicode code points in the comment-free proof."""
    return sum(not char.isspace() for char in proof)


SCORER = score_v1


def limit_child():
    if sys.platform.startswith("linux"):
        _, hard = resource.getrlimit(resource.RLIMIT_AS)
        cap = MAX_ADDRESS_SPACE if hard == resource.RLIM_INFINITY else min(hard, MAX_ADDRESS_SPACE)
        resource.setrlimit(resource.RLIMIT_AS, (cap, cap))


def remaining_time(stage, deadline):
    seconds = deadline - time.monotonic()
    if seconds <= 0:
        raise Rejected(f"{stage} timed out (120 s checker limit)")
    return seconds


def run(stage, argv, scratch, deadline, env):
    remaining_time(stage, deadline)
    worker = subprocess.Popen(
        argv, cwd=scratch, env=env, stdin=subprocess.DEVNULL,
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT, start_new_session=True,
        preexec_fn=limit_child,
    )
    output = bytearray()
    try:
        with worker.stdout as stream:
            while select.select([stream], [], [], remaining_time(stage, deadline))[0]:
                chunk = os.read(stream.fileno(), 65536)
                if not chunk:
                    break
                output.extend(chunk[:MAX_RESULT_BYTES - len(output)])
        worker.wait(timeout=remaining_time(stage, deadline))
    except subprocess.TimeoutExpired as error:
        raise Rejected(f"{stage} timed out (120 s checker limit)") from error
    finally:
        with contextlib.suppress(ProcessLookupError):
            os.killpg(worker.pid, signal.SIGKILL)
        worker.wait()
    if worker.returncode:
        diagnostic = output[:MAX_DIAGNOSTIC_BYTES].decode("utf-8", "replace").strip()
        try:
            reason = json.loads(diagnostic).get("reason", diagnostic)
        except (ValueError, AttributeError):
            reason = diagnostic
        reason = reason.replace(f"{scratch}{os.sep}", "")
        raise Rejected(f"{stage} failed: {reason or f'exit {worker.returncode}'}")
    return output.decode("utf-8", "replace").strip()


def read_policy(path):
    metadata = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(metadata, dict):
        raise Rejected("theorem.json must be a JSON object")
    for field in ("imports", "forbidden"):
        values = metadata.get(field)
        if not isinstance(values, list) or not all(isinstance(item, str) for item in values):
            raise Rejected(f"invalid theorem.json field {field}")
    if not isinstance(metadata.get("name"), str) or not metadata["name"]:
        raise Rejected("invalid theorem.json field name")
    fingerprint = metadata.get("statement_hash")
    if not isinstance(fingerprint, str) or (fingerprint and not re.fullmatch("[0-9a-f]{64}", fingerprint)):
        raise Rejected("invalid theorem.json field statement_hash")
    return metadata


def check(executable, packet, source, verdict):
    deadline = time.monotonic() + MAX_ELAPSED_SECONDS
    raw, text = read_source(source)
    clean = strip_comments(text).encode("utf-8")
    policy = read_policy(packet / "theorem.json")
    digest = hashlib.sha256(raw).hexdigest()
    root = Path(__file__).resolve().parents[1]
    env = os.environ.copy()
    lean = env.get("LEAN", "lean")
    with tempfile.TemporaryDirectory(prefix=f"golfcheck-{digest}-", dir=root / ".lake") as directory:
        scratch = Path(directory)
        submission = scratch / "GolfSubmission.lean"
        reference = scratch / "GolfReference.lean"
        policy_file = scratch / "policy.json"
        submission.write_bytes(clean)
        policy_file.write_text(json.dumps(policy), encoding="utf-8")

        offset = json.loads(run(
            "source lint", [executable, "--parse", str(submission), policy["name"], *policy["imports"]],
            scratch, deadline, env,
        ))
        reference.write_bytes((packet / "Statement.lean").read_bytes())
        for stage, module in (("submission compilation", submission), ("reference compilation", reference)):
            run(stage, [lean, "-j", "1", "-t", "0", "-M", str(LEAN_MEMORY_MIB),
                        "-R", str(scratch), "-o", module.with_suffix(".olean").name, str(module)],
                scratch, deadline, env)

        certificate = json.loads(run(
            "certificate verification",
            [executable, "--verify", str(reference.with_suffix(".olean")),
             str(submission.with_suffix(".olean")), policy["name"], str(policy_file)],
            scratch, deadline, env,
        ))
        verdict["statement_hash"] = hashlib.sha256(certificate["fingerprint"].encode("utf-8")).hexdigest()
        verdict["axioms"] = certificate["axioms"]
        if policy["statement_hash"] and policy["statement_hash"] != verdict["statement_hash"]:
            raise Rejected("statement_hash does not match Statement.lean")
        if certificate["reason"]:
            raise Rejected(certificate["reason"])
        verdict.update(valid=True, score=SCORER(clean[offset:].decode("utf-8")))


def interrupted(_signal, _frame):
    raise KeyboardInterrupt


def main():
    signal.signal(signal.SIGTERM, interrupted)
    verdict = {"valid": False, "score": None, "statement_hash": "", "axioms": [], "reason": ""}
    try:
        executable, theorem_dir, submission = sys.argv[1:]
        check(str(Path(executable).resolve()), Path(theorem_dir), Path(submission), verdict)
    except (Rejected, OSError, ValueError, KeyError, TypeError, subprocess.SubprocessError) as error:
        verdict["reason"] = str(error)
    except KeyboardInterrupt:
        verdict["reason"] = "checker interrupted"
    print(json.dumps(verdict, ensure_ascii=False, separators=(",", ":")))
    return 0 if verdict["valid"] else 1


if __name__ == "__main__":
    sys.exit(main())
