import hashlib
import json
import os
from pathlib import Path
import subprocess
import time

import pytest


ROOT = Path(__file__).resolve().parents[1]
ENV = os.environ | {"PATH": f"{Path.home() / '.elan/bin'}{os.pathsep}{os.environ['PATH']}"}
AXIOMS = {"propext", "Classical.choice", "Quot.sound"}
SEEDS = (
    "am-gm", "cantor", "euclid-lemma", "fermat-little", "imo-1959-p1",
    "inf-primes", "sqrt-two", "sum-cubes", "sum-odds", "wilson",
)
FIXTURE = "theorem LeanGolf.fixture : True"


@pytest.fixture(scope="session", autouse=True)
def build_checker():
    subprocess.run(["lake", "-q", "build", "golfcheck"], cwd=ROOT, env=ENV,
                   check=True, timeout=60)


@pytest.fixture
def packet(tmp_path):
    def make(statement=FIXTURE, imports=(), forbidden=(), statement_hash=""):
        directory = tmp_path / "fixture"
        directory.mkdir(exist_ok=True)
        header = "".join(f"import {module}\n" for module in imports)
        (directory / "Statement.lean").write_text(f"{header}{statement} := by sorry\n")
        metadata = {
            "slug": "fixture", "title": "Checker fixture", "name": "LeanGolf.fixture",
            "imports": list(imports), "forbidden": list(forbidden),
            "statement_hash": statement_hash, "source": "Local fixture",
            "added_utc": "2026-11-27T00:00:00Z",
        }
        (directory / "theorem.json").write_text(json.dumps(metadata))
        return directory
    return make


def invoke(packet_path, submission_file):
    process = subprocess.run(
        ["lake", "-q", "--no-build", "exe", "golfcheck", str(packet_path), str(submission_file)],
        cwd=ROOT, env=ENV, text=True, capture_output=True, timeout=145,
    )
    assert len(process.stdout.splitlines()) == 1, (process.stdout, process.stderr)
    result = json.loads(process.stdout)
    assert result.keys() == {"valid", "score", "statement_hash", "axioms", "reason"}
    assert process.returncode == (0 if result["valid"] else 1), (result, process.stderr)
    return result


def submit(packet_path, body):
    path = packet_path.parent / "Candidate.lean"
    path.write_text(body, encoding="utf-8")
    return invoke(packet_path, path)


def rejected(result, reason):
    assert result["valid"] is False, result
    assert result["score"] is None
    assert reason in result["reason"], result


@pytest.mark.parametrize(
    ("source", "reason"),
    [
        (f"{FIXTURE} := by sorry", "banned token sorry"),
        (f"{FIXTURE} := by admit", "banned token admit"),
        (f"{FIXTURE} := by native_decide", "banned token native_decide"),
        (f"{FIXTURE} := Lean.ofReduceBool (by decide)", "banned token Lean.ofReduceBool"),
        (f"{FIXTURE} := _root_.Lean.ofReduceBool (by decide)", "banned token Lean.ofReduceBool"),
        (f"axiom bogus : True\n{FIXTURE} := bogus", "banned token axiom"),
        (f"namespace Other\n{FIXTURE} := True.intro\nend Other", "banned token namespace"),
        (f"import Lean\n{FIXTURE} := True.intro", "unapproved import Lean"),
        (f"prelude\n{FIXTURE} := True.intro", "prelude"),
        (f"macro foo : term => foo\n{FIXTURE} := True.intro", "banned token macro"),
        (f"notation X => True\n{FIXTURE} := True.intro", "banned token notation"),
        (f"syntax ident : term\n{FIXTURE} := True.intro", "banned token syntax"),
        (f"elab foo : term => foo\n{FIXTURE} := True.intro", "banned token elab"),
        (f"set_option maxRecDepth 1\n{FIXTURE} := True.intro", "banned token set_option"),
        (f"{FIXTURE} := by set_option maxRecDepth 5 in trivial", "banned token set_option"),
        (f"@[implemented_by f] {FIXTURE} := True.intro", "banned token @["),
        (f"@[extern f] {FIXTURE} := True.intro", "banned token @["),
        (f"@[csimp] {FIXTURE} := True.intro", "banned token @["),
        (f"#eval 0\n{FIXTURE} := True.intro", "banned token #eval"),
        (f"run_cmd pure ()\n{FIXTURE} := True.intro", "banned token run_cmd"),
        (f"{FIXTURE} := by\n  run_tac pure ()\n  trivial", "banned token run_tac"),
        (f"run_elab pure ()\n{FIXTURE} := True.intro", "banned token run_elab"),
        (f"run_meta pure ()\n{FIXTURE} := True.intro", "banned token run_meta"),
        (f"{FIXTURE} := by_elab pure default", "banned token by_elab"),
        (f"{FIXTURE} := True.intro\ntheorem Other.extra : True := True.intro", "exactly one theorem"),
        ("theorem LeanGοlf.fixture : True := True.intro", "theorem name"),
        ("def LeanGolf.fixture : True := True.intro", "plain theorem declaration"),
        (f'{FIXTURE} := (fun _ : String => True.intro) "sorry"', "string literals are forbidden"),
        ("theorem LeanGolf.«fixture» : True := True.intro", "quoted identifiers are forbidden"),
        (f"{FIXTURE} := True.intro\n/- /- -/ ", "unterminated block comment"),
        (f"{FIXTURE} := True.intro\n#check Nat", "exactly one theorem"),
    ],
)
def test_source_rejections(packet, source, reason):
    rejected(submit(packet(), source + "\n"), reason)


def test_cannot_redefine_statement_constant(packet):
    module = "Mathlib.Data.Nat.Prime.Defs"
    statement = "theorem LeanGolf.fixture : Nat.Prime 2"
    directory = packet(statement, imports=(module,))
    result = submit(directory, f"""import {module}
def Nat.Prime (_ : Nat) := True
{statement} := True.intro
""")
    rejected(result, "expected one plain theorem declaration")


@pytest.mark.parametrize(
    ("reference", "candidate", "imports"),
    [
        ("(h : False) : True", "(h : True) : True := True.intro", ()),
        ("{α : Type u} (a : α) : a = a", "{α : Type} (a : α) : a = a := rfl", ()),
        ("{α : Type u} (a : α) : a = a", "{α : Type (u + 1)} (a : α) : a = a := rfl", ()),
        ("(n : Nat) : True", "{n : Nat} : True := True.intro", ()),
        (": True", ": id True := True.intro", ()),
        (": ∃ n : Nat, n = 0",
         ": ∃! n : Nat, n = 0 := ⟨0, rfl, fun _ h => h⟩", ("Mathlib.Logic.ExistsUnique",)),
    ],
)
def test_changed_statement(packet, reference, candidate, imports):
    header = "".join(f"import {module}\n" for module in imports)
    prefix = "theorem LeanGolf.fixture "
    result = submit(packet(prefix + reference, imports), f"{header}{prefix}{candidate}\n")
    rejected(result, "statement type differs")
    assert len(result["statement_hash"]) == 64


def test_universe_parameter_can_be_renamed(packet):
    directory = packet("theorem LeanGolf.fixture {α : Type u} (a : α) : a = a")
    result = submit(directory, "theorem LeanGolf.fixture {α : Type v} (a : α) : a = a := rfl\n")
    assert result["valid"], result


def test_independent_axiom_check(packet):
    result = submit(packet(), f"{FIXTURE} := sorryAx True false\n")
    rejected(result, "disallowed axiom sorryAx")
    assert "sorryAx" in result["axioms"]


def test_native_decide_configuration_rejected_by_axiom_check(packet):
    result = submit(packet(), f"{FIXTURE} := by decide +native\n")
    rejected(result, "disallowed axiom")
    assert set(result["axioms"]) - AXIOMS


def test_allowlisted_axiom(packet):
    source = f"{FIXTURE} := Classical.choice (show Nonempty True from ⟨True.intro⟩)\n"
    result = submit(packet(), source)
    assert result["valid"], result
    assert result["axioms"] == ["Classical.choice"]


def test_forbidden_constant_in_proof_value(packet):
    statement = "theorem LeanGolf.fixture (n : Nat) : 0 ≤ n"
    directory = packet(statement, forbidden=("Nat.zero_le",))
    rejected(submit(directory, f"{statement} := Nat.zero_le n\n"), "forbidden constant Nat.zero_le")
    result = submit(directory, f"{statement} := by omega\n")
    assert result["valid"], result


def test_reference_hash_is_checked(packet):
    directory = packet(statement_hash="0" * 64)
    result = submit(directory, f"{FIXTURE} := True.intro\n")
    rejected(result, "statement_hash does not match Statement.lean")
    assert result["statement_hash"] != "0" * 64


def test_scoring_uses_parsed_delimiter_and_only_proof_code_points(packet):
    statement = "theorem LeanGolf.fixture : (let p := True; p)"
    directory = packet(statement, imports=("Init.Data.Nat.Basic",))
    source = f"""/- sorry\t/- "notation" -/ admit -/
{statement} := by
  exact/- Lean.ofReduceBool -/⟨⟩ -- native_decide
"""
    short = submit(directory, source.replace("\n", "\r\n"))
    long = submit(directory, f"{statement} := by exact True.intro\n")
    assert short["valid"] and long["valid"], (short, long)
    assert short["score"] == len("byexact⟨⟩") < long["score"] == len("byexactTrue.intro")
    assert short["statement_hash"] == long["statement_hash"]


def test_byte_limit_counts_utf8_and_accepts_exact_boundary(packet):
    directory = packet()
    text = f"{FIXTURE} := by trivial\n--"
    within = text + "a" * (65536 - len(text))
    result = submit(directory, within)
    assert result["valid"], result
    rejected(submit(directory, text + "λ" * (65 * 1024 // 2)), "exceeds 64 KB")


def test_wall_clock_limit(packet):
    start = time.monotonic()
    source = f"{FIXTURE} := by\n  sleep 130000\n  trivial\n"
    result = submit(packet(), source)
    rejected(result, "submission compilation timed out (120 s checker limit)")
    assert 119 <= time.monotonic() - start < 140
    digest = hashlib.sha256(source.encode()).hexdigest()
    assert not list((ROOT / ".lake").glob(f"golfcheck-{digest}-*"))


@pytest.mark.parametrize("slug", SEEDS)
def test_seed_record(slug):
    directory = ROOT / "theorems" / slug
    metadata = json.loads((directory / "theorem.json").read_text())
    record = json.loads((directory / "record.json").read_text())
    result = invoke(directory, directory / "Record.lean")
    assert result["valid"], result
    assert result["score"] == record["score"]
    assert result["statement_hash"] == metadata["statement_hash"]
    assert set(result["axioms"]) <= AXIOMS
    assert record["holder"] == "lean-golf-seed" and record["pr"] is None
