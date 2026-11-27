#!/usr/bin/env python3
"""Extract statement packets from pinned local sources and retain checker-verified packets."""

import argparse
from collections import Counter, defaultdict
from concurrent.futures import ThreadPoolExecutor, as_completed
from contextlib import suppress
from dataclasses import dataclass
import json
import os
from pathlib import Path
import re
import shutil
import signal
import subprocess
from tempfile import TemporaryDirectory
from threading import Event
from time import monotonic
from urllib.parse import quote

from check_source import Rejected, statement_hash, statement_template


ROOT = Path(__file__).resolve().parents[1]
# The pinned snapshot dates are independent of when the import is reproduced.
ADDED_UTC = "2026-11-27T00:00:00Z"
MAX_WORKERS = 6
CHECK_TIMEOUT = 125
BATCH_SIZE = 32


@dataclass(frozen=True)
class Source:
    key: str
    label: str
    clone: str
    files: str
    repository: str
    revision: str
    license: str
    license_path: str
    credit: str


SOURCES = (
    Source("minif2f", "miniF2F", "miniF2F-lean4", "MiniF2F/*/*.lean",
           "yangky11/miniF2F-lean4", "5746b7d6c47855ce1294bed87329618ff7f1bc31",
           "MIT", "LICENSE", "Copyright (c) Meta Platforms, Inc. and affiliates."),
    Source("putnambench", "PutnamBench", "PutnamBench", "lean4/src/*.lean",
           "trishullab/PutnamBench", "a635813f5edf297d928f9bd5ef8324a26bdde09c",
           "Apache-2.0", "lean4/LICENSE", "PutnamBench contributors (Tsoukalas et al.)."),
    Source("compfiles", "Compfiles", "compfiles", "Compfiles/*.lean",
           "dwrensha/compfiles", "a2b17da334d7dd125cc63d5fe557ab4c9dcc786a",
           "Apache-2.0", "LICENSE", "The Compfiles Contributors"),
    Source("proofnet", "ProofNet", "ProofNet-lean4", "formal/*.lean",
           "rahul3613/ProofNet-lean4", "6deae98b38954dadf732746d023e8be65c56f246",
           "MIT", "LICENSE", "Copyright (c) 2024 Rahul Vishwakarma. Original dataset: ProofNet."),
)

IDENT = r"[^\W\d][\w'₀-₉ᵢⱼ]*"
NAME = re.compile(rf"{IDENT}(?:\.{IDENT})*")
WORDS = re.compile(IDENT)
COMMAND = re.compile(
    r"(?m)^(?P<modifiers>(?:(?:noncomputable|private|protected|local|scoped|public|"
    r"unsafe|partial|nonrec|meta)\s+)*)"
    r"(?P<kind>theorem|lemma|example|problem|determine|problem_answer|abbrev|def|"
    r"instance|structure|class|inductive|coinductive|opaque|axiom|constant|"
    r"namespace|section|end|open|variable|variables|universe|universes|include|omit|"
    r"set_option|notation3?|infix[lr]?|prefix|postfix|attribute|export|import|"
    r"module|prelude|mutual|deriving|initialize|builtin_initialize|problem_file|snip|"
    r"syntax|macro(?:_rules)?|elab(?:_rules)?|run_(?:cmd|tac|elab)|"
    r"noncomputable|#\w+|@\[)(?=[:\s]|$|(?<=@\[))"
)
NAMED = {
    "theorem", "lemma", "problem", "determine", "problem_answer", "abbrev", "def",
    "instance", "structure", "class", "inductive", "coinductive", "opaque", "axiom",
    "constant",
}
DEFINITIONS = {"abbrev", "def", "structure", "class", "inductive"}
ANSWERS = {"determine", "problem_answer"}
CONTEXT = {"open", "variable", "variables", "universe", "universes", "include", "omit"}
NOTATION = {"notation", "notation3", "infix", "infixl", "infixr", "prefix", "postfix"}
STATEMENT_OPTIONS = {"set_option checkBinderAnnotations false", "set_option synthInstance.maxSize 127"}
CONTEXT_ATTRIBUTE = re.compile(r"attribute \[(?:local (?:instance|simp|irreducible|reducible)|-instance)\]")
# Usa2026P1 imports a verified theorem only for its proof. Its statement and
# answer definitions are self-contained in the source file.
PROOF_ONLY_IMPORTS = {Path("Compfiles/Usa2026P1.lean"): {"Compfiles.Usa1981P5"}}
UNSAFE_CONTEXT = re.compile(
    r"(?m)(?:\b(?:sorry(?:Ax)?|admit|axiom|unsafe|partial|native_decide|ofReduceBool|"
    r"macro|elab|run_cmd|run_tac|run_elab|run_meta|by_elab|include_str)\b|^\s*#\w+)"
)
LITERAL = re.compile(r"""(?:"(?:[^"\\]|\\.)*"|'(?:[^'\\\n]|\\.)')""")
COPYRIGHT = re.compile(r"Copyright \(c\)[^\n]*?(?:All rights reserved\.|(?=\n|-/))")
AUTHORS = re.compile(r"(?mi)\bAuthors?:[ \t]*([^\n]*?)(?=[ \t]*-/|\n|$)")


def mask(text):
    """Hide Lean comments and literals while retaining string indices and line breaks."""
    masked = []
    pos = 0

    def hidden(fragment, fill):
        return "".join("\n" if char == "\n" else fill for char in fragment)

    while pos < len(text):
        if text.startswith("--", pos):
            end = text.find("\n", pos)
            if end == -1:
                end = len(text)
            masked.append(hidden(text[pos:end], " "))
            pos = end
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
            masked.append(hidden(text[start:pos], " "))
        else:
            char = text[pos]
            if char == '"' or (char == "'" and (not pos or not
                    (text[pos - 1].isalnum() or text[pos - 1] in "_'"))):
                literal = LITERAL.match(text, pos)
                if literal:
                    masked.append(hidden(literal[0], "?"))
                    pos = literal.end()
                    continue
            masked.append(char)
            pos += 1
    return "".join(masked)


def proof_separator(code, start):
    """Locate the outer := while ignoring binders, brackets, and assignments in lets."""
    stack = []
    brackets = {"(": ")", "[": "]", "{": "}", "⟨": "⟩", "⟪": "⟫", "⌈": "⌉", "⌊": "⌋"}
    pending_lets = 0
    bindings = {"let", "letI", "let_fun", "have", "haveI"}
    for match in re.finditer(r":=|\b(?:let|letI|let_fun|have|haveI)\b|[()\[\]{}⟨⟩⟪⟫⌈⌉⌊⌋]",
                             code[start:]):
        token = match[0]
        if token in brackets:
            stack.append(brackets[token])
        elif stack and token == stack[-1]:
            stack.pop()
        elif not stack:
            if token in bindings:
                pending_lets += 1
            elif token == ":=":
                if pending_lets:
                    pending_lets -= 1
                else:
                    return start + match.start()
    return None


@dataclass
class Command:
    kind: str
    modifiers: str
    text: str
    code: str
    name: str
    name_end: int
    trailing: str
    scopes: tuple
    closes: int = -1


def commands(text):
    code = mask(text)
    matches = list(COMMAND.finditer(code))
    result, scopes = [], []
    for index, match in enumerate(matches):
        start = match.start()
        end = matches[index + 1].start() if index + 1 < len(matches) else len(code)
        trimmed = start + len(code[start:end].rstrip())
        kind = match["kind"]
        token_start = match.end() + len(code[match.end():end]) - len(code[match.end():end].lstrip())
        name = NAME.match(code, token_start) if kind in NAMED and token_start < trimmed else None
        closes = scopes.pop() if kind == "end" and scopes else -1
        result.append(Command(kind, match["modifiers"].strip(), text[start:trimmed],
                              code[start:trimmed], name[0] if name else "",
                              name.end() - start if name else 0, text[trimmed:end], tuple(scopes),
                              closes))
        if kind in {"namespace", "section"}:
            scopes.append(index)
    return result


class Skip(ValueError):
    pass


def definition(command):
    """Recover source-provided data, including the adjacent PutnamBench answer comment."""
    text = command.text
    name = command.name
    if command.kind in ANSWERS or name.endswith("_solution"):
        separator = proof_separator(command.code, command.name_end)
        if separator is None:
            raise Skip("answer placeholder")
        rhs = command.code[separator + 2:].strip()
        if rhs in {"sorry", "by sorry", "admit", "by admit"} and name.endswith("_solution"):
            lines = []
            for line in command.trailing.partition("\n")[2].splitlines():
                match = re.fullmatch(r"\s*--[ \t]?(.*)", line)
                if not match:
                    break
                lines.append(match[1])
            answer = "\n".join(lines).strip()
            if not answer:
                raise Skip("answer placeholder")
            text = text[:separator + 2] + "\n  " + answer.replace("\n", "\n  ")
        elif UNSAFE_CONTEXT.search(rhs):
            raise Skip("answer placeholder")
        if command.kind in ANSWERS:
            text = re.sub(r"\b(?:determine|problem_answer)\b", "abbrev", text, count=1)
    if command.modifiers.split() not in ([], ["noncomputable"]):
        raise Skip("unsupported local declaration")
    if UNSAFE_CONTEXT.search(mask(text)):
        raise Skip("unsupported local declaration")
    return text


def trusted_context(entries, index, statement, *, instances=False):
    """Select lexical dependencies and reproduce the scopes in which they occur."""
    prior = entries[:index]
    local = defaultdict(list)
    for position, command in enumerate(prior):
        if command.name and command.kind in DEFINITIONS | ANSWERS:
            local[command.name.rsplit(".", 1)[-1]].append(position)

    selected = {}
    scopes = set()
    context_commands = [(i, command) for i, command in enumerate(prior) if
                        command.kind in CONTEXT
                        or (command.kind in NOTATION and command.modifiers in {"", "local", "scoped"})
                        or (instances and command.kind == "instance")
                        or CONTEXT_ATTRIBUTE.match(command.code)
                        or command.code in STATEMENT_OPTIONS]

    def add_context(before):
        active = entries[before].scopes
        scopes.update(active)
        for position, command in context_commands:
            if position >= before:
                break
            if position in selected or active[:len(command.scopes)] != command.scopes:
                continue
            text = command.text
            if command.code.endswith(" in"):
                if position + 1 != before:
                    continue
                if before == index:
                    # The theorem is the next and final command in the packet.
                    text = text[:-3]
            if UNSAFE_CONTEXT.search(command.code):
                if command.kind == "instance":
                    raise Skip("unsupported source instance")
                continue
            selected[position] = text
            if command.kind != "set_option":
                add_dependencies(text, position)

    def add_dependencies(text, before):
        for word in dict.fromkeys(WORDS.findall(mask(text))):
            choices = local.get(word, ())
            for position in reversed(choices):
                if position >= before:
                    continue
                if position not in selected:
                    selected[position] = definition(prior[position])
                    if position + 1 < before and prior[position + 1].kind == "deriving":
                        deriving = prior[position + 1]
                        if not UNSAFE_CONTEXT.search(deriving.code):
                            selected[position] += "\n" + deriving.text
                    add_dependencies(selected[position], position)
                    add_context(position)
                break

    add_context(index)
    add_dependencies(statement, index)
    # Recreate namespaces even when a needed helper was declared in a scope
    # that closed before the theorem, while dropping unrelated proof scopes.
    selected.update({position: command.text for position, command in enumerate(prior)
                     if position in scopes or command.closes in scopes})
    result = [selected[position] for position in sorted(selected)]
    if any(prior[position].kind in DEFINITIONS | ANSWERS | {"instance"} for position in selected):
        result.insert(0, "noncomputable section")
    return "\n\n".join(result)


def declared_imports(entries, path):
    imports = []
    for command in entries:
        if command.kind != "import" or "meta" in command.modifiers.split():
            continue
        for module in command.code.split("import", 1)[1].split():
            if not NAME.fullmatch(module):
                raise Skip("unsupported import syntax")
            if module == "ProblemExtraction" or module in PROOF_ONLY_IMPORTS.get(path, ()):
                continue
            if module.startswith("Compfiles."):
                raise Skip("cross-file source context")
            if module not in imports:
                imports.append(module)
    return imports


def source_credit(source, text):
    # Compfiles uses both single-line and multiline copyright headers.
    match = re.match(r"\s*/-([\s\S]*?)-/", text)
    if not match:
        return source.credit
    credit = [m[0].strip() for m in COPYRIGHT.finditer(match[1] + "\n")]
    credit.extend(m[0].strip() for m in AUTHORS.finditer(match[1] + "\n") if m[1].strip())
    return " ".join(credit) or source.credit


def display_labels(source, path, name):
    if source.key == "minif2f":
        return name, name.split("_", 1)[0]
    if source.key == "putnambench":
        match = re.fullmatch(r"putnam_(\d+)_([ab]\d+)", name)
        difficulty = f"{match[1]} {match[2].upper()}" if match else "Putnam"
        return f"Putnam {difficulty}", difficulty
    if source.key == "proofnet":
        return f"{path.stem} · {name.replace('_', ' ')}", path.stem
    prefix = re.match(r"[^\d]+", path.stem)
    competition = prefix[0] if prefix else path.stem
    return name.replace("_", " ").upper(), competition


def extract(source, path, text):
    """Yield (problem name, packet or skip reason) for every source declaration."""
    entries = commands(text)
    seen = set()
    for index, command in enumerate(entries):
        if source.key == "compfiles":
            candidate = command.kind == "problem"
        elif source.key == "proofnet":
            candidate = command.kind in {"theorem", "instance", "lemma"}
        else:
            candidate = command.kind == "theorem"
        if not candidate:
            continue
        try:
            if command.kind not in {"theorem", "problem", "lemma"}:
                raise Skip("not a theorem declaration")
            if not command.name or "." in command.name or not command.name.isascii():
                raise Skip("unsupported declaration name")
            if command.modifiers:
                raise Skip("unsupported theorem modifier")
            separator = proof_separator(command.code, command.name_end)
            if separator is None:
                raise Skip("unsupported proof delimiter")
            body = command.text[command.name_end:separator]
            if not body.strip():
                raise Skip("missing explicit statement")
            imports = declared_imports(entries[:index], path)
            preamble = trusted_context(entries, index, body, instances=source.key == "compfiles")
            problem = command.name
            if source.key == "proofnet":
                problem = path.stem.lower().replace("-", "_") + "_" + problem
            slug_id = re.sub(r"[^a-z0-9_]+", "-", problem.lower()).strip("-")
            lean_id = re.sub(r"[^A-Za-z0-9_]", "_", problem)
            slug = f"{source.key}-{slug_id}"
            if slug in seen:
                raise Skip("duplicate source ID")
            seen.add(slug)
            name = f"LeanGolf.{source.key}.{lean_id}"
            declaration = f"theorem {'_root_.' if any(entries[i].kind == 'namespace' for i in command.scopes) else ''}{name}"
            title, difficulty = display_labels(source, path, command.name)
            metadata = dict(
                slug=slug, title=title, name=name, imports=imports, forbidden=[],
                statement_hash="", added_utc=ADDED_UTC, source=source.label,
                source_url=f"https://github.com/{source.repository}/blob/{source.revision}/{quote(path.as_posix())}",
                license=source.license, credit=source_credit(source, text), difficulty=difficulty,
            )
            header = "".join(f"import {module}\n" for module in imports)
            context = f"{preamble}\n\n" if preamble else ""
            statement = f"{header}\n{context}{declaration}{body}:= by sorry\n".lstrip("\n")
            yield command.name, (metadata, statement)
        except Skip as reason:
            yield command.name, str(reason)


def write_json(path, data):
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
                    encoding="utf-8")


def error_kind(reason):
    if "timed out" in reason:
        return "timeout"
    if "object file" in reason and "does not exist" in reason:
        return "missing pinned import"
    if "Unknown namespace" in reason or "unknown namespace" in reason:
        return "unknown namespace"
    if re.search(r"unknown (?:constant|identifier)|invalid field|Invalid field", reason, re.I):
        return "unresolved identifier or field"
    if re.search(r"type (?:mismatch|expected)|invalid binder annotation|typeclass|failed to synthesize",
                 reason, re.I):
        return "type or instance mismatch"
    if re.search(r"ambiguous term|overloaded|invalid dotted identifier", reason, re.I):
        return "ambiguous or overloaded term"
    if "unexpected token" in reason or "expected token" in reason or "unexpected end" in reason:
        return "syntax or notation"
    if "disallowed generated declaration" in reason:
        return "disallowed generated declaration"
    if "memory" in reason.lower():
        return "memory limit"
    if "disallowed axiom" in reason:
        return "disallowed axiom"
    if "banned token" in reason or "source lint" in reason:
        return "submission lint"
    if "must be a theorem" in reason or "is not a proposition" in reason:
        return "non-Prop declaration"
    return "other"


def run_checker(command, env, timeout, stop):
    process = subprocess.Popen(command, cwd=ROOT, env=env, start_new_session=True,
                               text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    deadline = monotonic() + timeout
    while True:
        try:
            output, diagnostics = process.communicate(timeout=max(.1, min(2, deadline - monotonic())))
            return process.returncode, output, diagnostics
        except subprocess.TimeoutExpired:
            if stop.is_set() or monotonic() >= deadline:
                # TERM lets the standalone Python checker reap its own Lean worker.
                with suppress(ProcessLookupError):
                    os.killpg(process.pid, signal.SIGTERM)
                try:
                    output, diagnostics = process.communicate(timeout=3)
                except subprocess.TimeoutExpired:
                    with suppress(ProcessLookupError):
                        os.killpg(process.pid, signal.SIGKILL)
                    output, diagnostics = process.communicate()
                return None, output, diagnostics


def harvest(target, stage, metadata, text, digest):
    slug = metadata["slug"]
    metadata = dict(metadata, statement_hash=digest)
    final = target / slug
    if final.exists():
        if ((final / "Statement.lean").read_text(encoding="utf-8") != text
                or json.loads((final / "theorem.json").read_text(encoding="utf-8")) != metadata):
            raise RuntimeError(f"Existing packet differs from verified {slug}")
    else:
        with TemporaryDirectory(prefix=f"{slug}-", dir=stage) as directory:
            packet = Path(directory)
            (packet / "Statement.lean").write_text(text, encoding="utf-8")
            write_json(packet / "theorem.json", metadata)
            packet.rename(final)
    return "kept", digest


def check_candidate(target, stage, executable, timeout, env, metadata, text, stop):
    slug = metadata["slug"]
    with TemporaryDirectory(prefix=f"{slug}-", dir=stage) as directory:
        packet = Path(directory)
        (packet / "Statement.lean").write_text(text, encoding="utf-8")
        write_json(packet / "theorem.json", metadata)
        code, output, diagnostics = run_checker(
            [executable, "--statement", str(packet)], env, timeout, stop
        )
        if code is None:
            return ("deadline", "job interrupted") if stop.is_set() else ("timeout", "packet check timed out")
        try:
            result = json.loads(output)
        except ValueError:
            raise RuntimeError(f"Checker protocol failure on {slug}: {diagnostics[:300]}") from None
        if not result["valid"]:
            if code != 1 or not result["reason"]:
                raise RuntimeError(f"Checker failed unexpectedly on {slug}")
            return error_kind(result["reason"]), result["reason"].splitlines()[0]
        digest = result["statement_hash"]
        if code or not re.fullmatch("[0-9a-f]{64}", digest):
            raise RuntimeError(f"Checker returned an invalid receipt for {slug}")
        return harvest(target, stage, metadata, text, digest)


def check_batch(args, stage, executable, env, deadline, stop, group):
    def single(metadata, text):
        seconds = min(CHECK_TIMEOUT, deadline - monotonic() - 5)
        if stop.is_set() or seconds <= 0:
            return "deadline", "job deadline reached"
        return check_candidate(args.out, stage, executable, seconds, env, metadata, text, stop)

    if args.single:
        return [single(meta, text) for _, meta, text in group]
    seconds = min(CHECK_TIMEOUT, deadline - monotonic() - 5)
    if stop.is_set() or seconds <= 0:
        return [("deadline", "job deadline reached")] * len(group)
    indices, inputs, results = [], [], [None] * len(group)
    for index, (_, meta, text) in enumerate(group):
        try:
            preamble, clean = statement_template(text, meta)
        except Rejected as error:
            results[index] = error_kind(str(error)), str(error)
            continue
        indices.append(index)
        inputs.append(dict(name=meta["name"], allowed=meta["imports"], reference=text,
                           template=clean.decode("utf-8"), preamble=preamble))
    if inputs:
        with TemporaryDirectory(dir=stage, prefix="batch-") as directory:
            input_path = Path(directory) / "packets.jsonl"
            input_path.write_text("".join(json.dumps(item, ensure_ascii=False) + "\n"
                                          for item in inputs), encoding="utf-8")
            _, output, _ = run_checker([executable, "--statement-batch", str(input_path)],
                                       env, seconds, stop)
        outcomes = output.splitlines()
        for position, index in enumerate(indices):
            _, meta, statement = group[index]
            result = {}
            if position < len(outcomes) <= len(inputs):
                with suppress(ValueError):
                    result = json.loads(outcomes[position])
            if not isinstance(result, dict):
                result = {}
            if set(result) == {"fingerprint"} and isinstance(result["fingerprint"], str):
                digest = statement_hash(result["fingerprint"], meta)
                results[index] = harvest(args.out, stage, meta, statement, digest)
            else:
                results[index] = single(meta, statement)
    return results


def lake_environment(seconds):
    env = os.environ.copy()
    env["PATH"] = f"{Path.home() / '.elan' / 'bin'}{os.pathsep}{env['PATH']}"
    path, lean = subprocess.check_output(
        ["lake", "env", "sh", "-c", 'printf "%s\\n" "$LEAN_PATH"; command -v lean'],
        cwd=ROOT, env=env, text=True, timeout=min(30, seconds),
    ).splitlines()
    return env | {"LEAN_PATH": path, "LEAN": lean}


def source_packets(source, clone, search_path):
    """Plan every pinned candidate, including skips and import compatibility."""
    skips = Counter()
    receipts, jobs, seen = {}, [], set()
    candidates = 0
    tracked = subprocess.check_output(
        ["git", "-C", clone, "ls-tree", "-rz", "--name-only", "HEAD"], timeout=10
    ).decode("utf-8").split("\0")
    files = sorted(Path(path) for path in tracked if Path(path).match(source.files))
    for path in files:
        for name, packet in extract(source, path, (clone / path).read_text(encoding="utf-8")):
            candidates += 1
            origin = f"{path}:{name}"
            if isinstance(packet, str):
                skips[packet] += 1
                receipts[origin] = {"skip": packet}
            else:
                meta, statement = packet
                if meta["slug"] in seen:
                    suffix = re.sub(r"[^a-z0-9_]+", "_", path.stem.lower())
                    original_name = meta["name"]
                    meta["slug"] += f"-{suffix}"
                    meta["name"] += f"_{suffix}"
                    meta["title"] = path.stem
                    statement = re.sub(
                        r"(?m)^(theorem (?:_root_\.)?)" + re.escape(original_name),
                        lambda match: match[1] + meta["name"], statement, count=1,
                    )
                if meta["slug"] in seen:
                    skips["duplicate source ID"] += 1
                    receipts[origin] = {"skip": "duplicate source ID"}
                    continue
                seen.add(meta["slug"])
                # Compfiles tracks a newer Mathlib. Use the pinned umbrella for
                # moved modules, and retain the original list for provenance.
                missing = [module for module in meta["imports"] if module.startswith("Mathlib.")
                           and search_path and not any(
                               (root / (module.replace(".", "/") + ".olean")).is_file()
                               for root in search_path)]
                if missing:
                    meta["source_imports"] = meta["imports"]
                    meta["imports"] = list(dict.fromkeys(
                        "Mathlib" if module in missing else module for module in meta["imports"]
                    ))
                    statement = re.sub(
                        r"\A(?:import [^\n]+\n)+",
                        "".join(f"import {module}\n" for module in meta["imports"]),
                        statement,
                    )
                jobs.append((origin, meta, statement))
    return candidates, jobs, skips, receipts


def run_import(args, executable=None):
    deadline = monotonic() + args.seconds
    stop = Event()
    signal.signal(signal.SIGTERM, lambda *_: stop.set())
    signal.signal(signal.SIGINT, lambda *_: stop.set())
    env = None
    if not args.inventory:
        env = lake_environment(args.seconds)
        args.out.mkdir(parents=True, exist_ok=True)
    search_path = [Path(path) for path in env["LEAN_PATH"].split(os.pathsep)] if env else []
    report = {}
    for source in SOURCES:
        if args.source and source.key not in args.source:
            continue
        clone = args.sources / source.clone
        revision = subprocess.check_output(["git", "-C", clone, "rev-parse", "HEAD"],
                                           text=True, timeout=5).strip()
        if revision != source.revision:
            raise RuntimeError(f"Wrong {source.label} revision: {revision}")
        subprocess.run(["git", "-C", clone, "diff", "--no-ext-diff", "--quiet", "HEAD"],
                       check=True, timeout=10)
        candidates, jobs, skips, receipts = source_packets(source, clone, search_path)
        failures = Counter()
        source_result = report[source.label] = dict(
            candidates=candidates, extracted=len(jobs), kept=0, skipped=dict(skips),
            failed={}, unchecked=len(jobs), receipts=receipts,
        )
        if not args.inventory:
            lanes = defaultdict(list)
            for job in jobs:
                lanes[tuple(job[1]["imports"])].append(job)
            batches = [lane[start:start + BATCH_SIZE] for lane in lanes.values()
                       for start in range(0, len(lane), BATCH_SIZE)]
            parent = ROOT / ".lake" if args.out.parent == ROOT else args.out.parent
            with TemporaryDirectory(prefix=".lean-golf-import-", dir=parent) as directory:
                stage = Path(directory)

                def verify(group):
                    return check_batch(args, stage, executable, env, deadline, stop, group)

                completed = checkpoint = 0
                with ThreadPoolExecutor(max_workers=args.jobs) as workers:
                    pending = {workers.submit(verify, batch): batch for batch in batches}
                    for future in as_completed(pending):
                        batch = pending[future]
                        outcomes = future.result()
                        for (origin, meta, _), (outcome, detail) in zip(batch, outcomes):
                            completed += 1
                            if outcome != "deadline":
                                source_result["unchecked"] -= 1
                            if outcome == "kept":
                                source_result["kept"] += 1
                                receipts[origin] = {"slug": meta["slug"], "statement_hash": detail}
                            else:
                                failures[outcome] += 1
                                receipts[origin] = {"failure": outcome, "diagnostic": detail}
                        if completed - checkpoint >= 50 and not stop.is_set():
                            checkpoint = completed
                            source_result["failed"] = dict(failures)
                            if args.receipts:
                                write_json(args.receipts, report)
                            print(f"{source.label} checked {completed}/{len(jobs)}", flush=True)
            source_result["failed"] = dict(failures)
        if args.receipts:
            write_json(args.receipts, report)
        print(source.label, json.dumps({k: v for k, v in source_result.items() if k != "receipts"},
                                      ensure_ascii=False, sort_keys=True), flush=True)
    return any(item["unchecked"] for item in report.values()) and not args.inventory


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--sources", type=Path, default=ROOT / ".sources")
    parser.add_argument("--out", type=Path, default=ROOT / "theorems")
    parser.add_argument("--source", action="append", choices=[source.key for source in SOURCES])
    parser.add_argument("--jobs", type=int, choices=range(1, MAX_WORKERS + 1), default=2)
    parser.add_argument("--seconds", type=int, default=3600)
    parser.add_argument("--receipts", type=Path, help="Write per-declaration verification receipts")
    parser.add_argument("--inventory", action="store_true", help="Count extraction results without writing packets")
    parser.add_argument("--single", action="store_true", help="Run each packet in a fresh checker process")
    args = parser.parse_args()
    if args.seconds <= 5:
        parser.error("--seconds must exceed five seconds")
    args.sources = args.sources.resolve()
    args.out = args.out.resolve()
    if args.out.is_relative_to(args.sources) or (
        args.receipts and args.receipts.resolve().is_relative_to(args.sources)
    ):
        parser.error("the source clones are read-only")
    if args.inventory:
        return run_import(args)
    # Use an immutable executable while workers are running. Lake can replace
    # its build output during an independent test build.
    with TemporaryDirectory(prefix="lean-golf-import-bin-", dir=ROOT / ".lake") as directory:
        executable = Path(directory) / "golfcheck"
        shutil.copy2(ROOT / ".lake/build/bin/golfcheck", executable)
        return run_import(args, executable)


if __name__ == "__main__":
    raise SystemExit(main())
