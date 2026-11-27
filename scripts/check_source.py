"""Source preparation, process limits and public JSON protocol for golfcheck."""

import contextlib
import hashlib
import json
import os
from pathlib import Path
import re
import select
import signal
import stat
import subprocess
import sys
import tempfile
import time


MAX_SOURCE_BYTES = 64 * 1024
MAX_ELAPSED_SECONDS = 120
LEAN_MEMORY_MIB = 16384
MAX_DIAGNOSTIC_BYTES = 4096
MAX_RESULT_BYTES = 1024**2
CHAR_LITERAL = re.compile(r"'(?:[^'\\\n\r]|\\(?:x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|.))'")
REFERENCE_IMPORT = re.compile(r"(?m)^import [^\s]+[ \t]*\n")


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
    # 11-27: no address-space cap. Lean reserves large virtual regions (thread stacks, olean maps), so a 12 GiB
    # RLIMIT_AS failed thread creation on Linux at 1.2 GB of real memory. The container's cgroup limit bounds memory.
    return None


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


def reference_parts(reference, name):
    declaration_name = re.escape(name)
    command = re.search(r"(?m)^theorem[ \t]+(?:_root_\.)?" + declaration_name
                        + r"(?=\.?\{|/-|--|[\s(\[:])",
                        reference)
    if not command:
        raise Rejected("expected a reference theorem at the start of a line")
    before = reference[:command.start()]
    imports, pos = [], 0
    while match := REFERENCE_IMPORT.match(before, pos):
        imports.append(match[0])
        pos = match.end()
    return "".join(imports), before[pos:].strip(), reference[command.start():]


def lint(executable, source, clean, policy, preamble, scratch, deadline, env):
    source.write_bytes(clean)
    trusted = scratch / "PacketContext.lean"
    trusted.write_text(preamble, encoding="utf-8")
    return json.loads(run(
        "source lint", [executable, "--parse", str(source), policy["name"], str(trusted),
                        *policy["imports"]], scratch, deadline, env,
    ))


def compile_lean(module, stage, scratch, deadline, env):
    run(stage, [env.get("LEAN", "lean"), "-j", "1", "-t", "0", "-M", str(LEAN_MEMORY_MIB),
                "-R", str(scratch), "-o", module.with_suffix(".olean").name, str(module)],
        scratch, deadline, env)
    return str(module.with_suffix(".olean"))


def add_context(clean, header, preamble):
    if not preamble:
        return clean
    return clean[:header] + b"\n\n" + preamble.encode("utf-8") + b"\n\n" + clean[header:].lstrip()


def statement_hash(fingerprint, policy):
    digest = hashlib.sha256(fingerprint.encode("utf-8")).hexdigest()
    if policy["statement_hash"] and policy["statement_hash"] != digest:
        raise Rejected("statement_hash does not match Statement.lean")
    return digest


def check(executable, packet, source, verdict):
    deadline = time.monotonic() + MAX_ELAPSED_SECONDS
    raw, text = read_source(source)
    clean = strip_comments(text).encode("utf-8")
    policy = read_policy(packet / "theorem.json")
    digest = hashlib.sha256(raw).hexdigest()
    root = Path(__file__).resolve().parents[1]
    env = os.environ.copy()
    reference_text = (packet / "Statement.lean").read_text(encoding="utf-8")
    _, preamble, _ = reference_parts(reference_text, policy["name"])
    with tempfile.TemporaryDirectory(prefix=f"golfcheck-{digest}-", dir=root / ".lake") as directory:
        scratch = Path(directory)
        submission = scratch / "GolfSubmission.lean"
        reference = scratch / "GolfReference.lean"
        policy_file = scratch / "policy.json"
        policy_file.write_text(json.dumps(policy), encoding="utf-8")
        header, offset = lint(executable, submission, clean, policy, preamble, scratch, deadline, env)
        if preamble:
            submission.write_bytes(add_context(clean, header, preamble))
        reference.write_text(reference_text, encoding="utf-8")
        submission_olean = compile_lean(submission, "submission compilation", scratch, deadline, env)
        reference_olean = compile_lean(reference, "reference compilation", scratch, deadline, env)

        certificate = json.loads(run(
            "certificate verification",
            [executable, "--verify", reference_olean, submission_olean, policy["name"], str(policy_file)],
            scratch, deadline, env,
        ))
        verdict["statement_hash"] = hashlib.sha256(certificate["fingerprint"].encode("utf-8")).hexdigest()
        verdict["axioms"] = certificate["axioms"]
        if policy["statement_hash"] and policy["statement_hash"] != verdict["statement_hash"]:
            raise Rejected("statement_hash does not match Statement.lean")
        if certificate["reason"]:
            raise Rejected(certificate["reason"])
        verdict.update(valid=True, score=SCORER(clean[offset:].decode("utf-8")))


def statement_template(source, policy):
    imports, preamble, declaration = reference_parts(source, policy["name"])
    template, replaced = re.subn(r":=\s*by\s+sorry\s*\Z", ":= by trivial\n", declaration)
    if replaced != 1:
        raise Rejected("expected a reference theorem ending in := by sorry")
    clean = strip_comments(imports + "\n" + template).encode("utf-8")
    if len(clean) > MAX_SOURCE_BYTES:
        raise Rejected("statement exceeds the submission size limit")
    return preamble, clean


def check_statement(executable, packet):
    deadline = time.monotonic() + MAX_ELAPSED_SECONDS
    policy = read_policy(packet / "theorem.json")
    source = (packet / "Statement.lean").read_text(encoding="utf-8")
    preamble, clean = statement_template(source, policy)
    env = os.environ.copy()
    root = Path(__file__).resolve().parents[1]
    with tempfile.TemporaryDirectory(prefix="golfcheck-statement-", dir=root / ".lake") as directory:
        scratch = Path(directory)
        reference = scratch / "GolfReference.lean"
        reference.write_text(source, encoding="utf-8")
        compiled = compile_lean(reference, "reference compilation", scratch, deadline, env)
        draft = scratch / "GolfSubmission.lean"
        header, offset = lint(executable, draft, clean, policy, preamble, scratch, deadline, env)
        draft.write_bytes(add_context(clean[:offset] + b" by sorry\n", header, preamble))
        draft_olean = compile_lean(draft, "submission template compilation", scratch, deadline, env)
        fingerprint = json.loads(run(
            "statement verification", [executable, "--fingerprint", compiled, draft_olean, policy["name"],
                                       *policy["imports"]], scratch, deadline, env,
        ))
        return statement_hash(fingerprint, policy)


def interrupted(_signal, _frame):
    raise KeyboardInterrupt


def main():
    signal.signal(signal.SIGTERM, interrupted)
    verdict = {"valid": False, "score": None, "statement_hash": "", "axioms": [], "reason": ""}
    try:
        executable, theorem_dir, submission = sys.argv[1:]
        executable = str(Path(executable).resolve())
        if theorem_dir == "--statement":
            verdict.update(valid=True, statement_hash=check_statement(executable, Path(submission)))
        else:
            check(executable, Path(theorem_dir), Path(submission), verdict)
    except (Rejected, OSError, ValueError, KeyError, TypeError, subprocess.SubprocessError) as error:
        verdict["reason"] = str(error)
    except KeyboardInterrupt:
        verdict["reason"] = "checker interrupted"
    print(json.dumps(verdict, ensure_ascii=False, separators=(",", ":")))
    return 0 if verdict["valid"] else 1


if __name__ == "__main__":
    sys.exit(main())
