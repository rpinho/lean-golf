import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

import pytest


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))
from check_source import statement_template  # noqa: E402
from records import apply, read_history  # noqa: E402

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


def fingerprint(packet_path):
    process = subprocess.run(
        ["lake", "-q", "--no-build", "exe", "golfcheck", "--statement", str(packet_path)],
        cwd=ROOT, env=ENV, text=True, capture_output=True, timeout=145,
    )
    result = json.loads(process.stdout)
    assert process.returncode == (0 if result["valid"] else 1), process.stderr
    return result


def submit(packet_path, body):
    path = packet_path.parent / "Candidate.lean"
    path.write_text(body, encoding="utf-8")
    return invoke(packet_path, path)


def rejected(result, reason):
    assert result["valid"] is False, result
    assert result["score"] is None
    assert reason in result["reason"], result


SOURCE_CONTROLS = ROOT / "tests" / "controls" / "source"
SOURCE_REASONS = json.loads((SOURCE_CONTROLS / "reasons.json").read_text())


def test_all_source_controls_have_reasons():
    assert {path.stem for path in SOURCE_CONTROLS.glob("*.lean")} == set(SOURCE_REASONS)


@pytest.mark.parametrize("name,reason", sorted(SOURCE_REASONS.items()), ids=sorted(SOURCE_REASONS))
def test_source_rejections(packet, name, reason):
    rejected(invoke(packet(), SOURCE_CONTROLS / f"{name}.lean"), reason)


def test_cannot_redefine_statement_constant(packet):
    module = "Mathlib.Data.Nat.Prime.Defs"
    statement = "theorem LeanGolf.fixture : Nat.Prime 2"
    directory = packet(statement, imports=(module,))
    result = submit(directory, f"""import {module}
def Nat.Prime (_ : Nat) := True
{statement} := True.intro
""")
    rejected(result, "expected one plain theorem declaration")


TYPE_CONTROLS = ROOT / "tests" / "controls" / "type"
TYPE_PACKETS = json.loads((TYPE_CONTROLS / "packets.json").read_text())


def test_all_type_controls_have_packets():
    assert {path.stem for path in TYPE_CONTROLS.glob("*.lean")} == set(TYPE_PACKETS)


@pytest.mark.parametrize("name", sorted(TYPE_PACKETS))
def test_changed_statement(packet, name):
    result = invoke(packet(**TYPE_PACKETS[name]), TYPE_CONTROLS / f"{name}.lean")
    rejected(result, "statement type differs")
    assert len(result["statement_hash"]) == 64


def test_universe_parameter_can_be_renamed(packet):
    directory = packet("theorem LeanGolf.fixture {α : Type u} (a : α) : a = a")
    result = submit(directory, "theorem LeanGolf.fixture {α : Type v} (a : α) : a = a := rfl\n")
    assert result["valid"], result


def test_independent_axiom_check(packet):
    result = invoke(packet(), ROOT / "tests" / "controls" / "axiom" / "sorry-axiom.lean")
    rejected(result, "disallowed axiom sorryAx")
    assert "sorryAx" in result["axioms"]


def test_native_decide_configuration_rejected_by_axiom_check(packet):
    result = invoke(packet(), ROOT / "tests" / "controls" / "axiom" / "native-config.lean")
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


def test_contextual_open_theorem_sets_its_first_record(packet, tmp_path):
    declaration = "theorem _root_.LeanGolf.fixture : Answer"
    directory = packet()
    theorems = tmp_path / "theorems"
    theorems.mkdir()
    folder = directory.rename(theorems / "fixture")
    context = """namespace Imported
def grow : Nat → Nat
  | 0 => 1
  | n + 1 => grow n + grow n
abbrev Answer : Prop := grow 0 = 1"""
    (folder / "Statement.lean").write_text(f"{context}\n\n{declaration} := by sorry\n")
    verified_type = fingerprint(folder)
    assert verified_type["valid"], verified_type
    policy = folder / "theorem.json"
    meta = json.loads(policy.read_text())
    policy.write_text(json.dumps(dict(meta, statement_hash=verified_type["statement_hash"])))
    reference = (folder / "Statement.lean").read_text()
    preamble, template = statement_template(reference, meta)
    request = dict(name=meta["name"], allowed=meta["imports"], reference=reference,
                   preamble=preamble, template=template.decode())
    batch_file = tmp_path / "batch.jsonl"
    batch_file.write_text((json.dumps(request) + "\n") * 2)
    batch = subprocess.run(
        ["lake", "-q", "--no-build", "exe", "golfcheck", "--statement-batch", str(batch_file)],
        cwd=ROOT, env=ENV, text=True, capture_output=True, check=True, timeout=145,
    )
    fingerprints = [json.loads(line)["fingerprint"] for line in batch.stdout.splitlines()]
    assert [hashlib.sha256(item.encode()).hexdigest() for item in fingerprints] == [
        verified_type["statement_hash"], verified_type["statement_hash"],
    ]
    source = f"{declaration} := rfl\n"
    result = submit(folder, source)
    assert result["valid"], result
    assert result["score"] == len("rfl")
    assert result["statement_hash"] == verified_type["statement_hash"]
    rejected(submit(folder, f"{context}\n{source}"), "banned token namespace")
    rejected(submit(folder, f"{declaration.replace('Answer', 'True')} := True.intro\n"),
             "statement type differs")

    assert not (folder / "record.json").exists()
    assert apply(tmp_path, "fixture", "Player", 11, "2026-11-27T12:00:00Z", source.encode(), result)
    assert (folder / "Record.lean").read_text() == source
    assert json.loads((folder / "record.json").read_text())["score"] == result["score"]
    assert read_history(tmp_path / "data/history.jsonl")[0]["previous"] is None


def test_statement_verifier_rejects_answer_with_sorry(packet):
    folder = packet()
    (folder / "Statement.lean").write_text(
        "abbrev answer : Nat := sorry\ntheorem LeanGolf.fixture : answer = 0 := by sorry\n"
    )
    rejected(fingerprint(folder), "statement depends on disallowed axiom sorryAx")


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


def test_native_record_tie_through_ci(tmp_path, monkeypatch):
    import ci
    from test_ci import FakeGitHub, HEAD, SLUG, oid

    packet = ROOT / "theorems" / SLUG
    proof = (packet / "Record.lean").read_bytes()
    api = FakeGitHub(packet_root=ROOT)
    api.entry.update(size=len(proof), sha=oid(proof))
    api.files[0]["sha"] = oid(proof)
    api.blobs[oid(proof)] = proof

    def native_checker(root, item, expected_hash):
        path = tmp_path / "Submission.lean"
        path.write_bytes(item.content)
        result = invoke(root / "theorems" / item.slug, path)
        return ci.check_result(result, 0, expected_hash)

    monkeypatch.setattr(ci, "run_checker", native_checker)
    monkeypatch.setenv("GITHUB_STEP_SUMMARY", str(tmp_path / "summary"))
    monkeypatch.setenv("GITHUB_OUTPUT", str(tmp_path / "output"))
    run = dict(event="pull_request", conclusion="success", head_sha=HEAD, head_branch="feature",
               head_repository=dict(id=500, owner=dict(login="player")))
    event = dict(repository=dict(default_branch="main"), workflow_run=run)
    assert ci.verify(api, event, ROOT, tmp_path / "result", trusted=True) == 0
    key, raw = (tmp_path / "output").read_text().split("=", 1)
    assert key == "receipt"
    receipt = json.loads(raw)
    assert receipt["result"]["score"] == json.loads((packet / "record.json").read_text())["score"]
    assert ci.publish_record(api, "main", receipt) is False
    assert [method for _, method, _ in api.writes] == ["POST", "PATCH"]
    assert not api.record_commits
