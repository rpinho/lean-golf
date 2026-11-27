import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import xml.etree.ElementTree as ET

import pytest


ROOT = Path(__file__).resolve().parents[1]
FIXTURE = ROOT / "tests" / "fixtures"
SLUG = "inf-primes"
TIMESTAMP = "2026-11-27T01:00:00Z"
RESULT = json.loads((FIXTURE / "verified.json").read_text())
sys.path.insert(0, str(ROOT / "scripts"))
from records import apply, read_history, read_json  # noqa: E402
from check_workflows import test_workflow_boundaries  # noqa: E402, F401


def files(folder):
    return {path.relative_to(folder).as_posix(): path.read_bytes()
            for path in folder.rglob("*") if path.is_file()}


def test_strict_improvement_totals_and_history(tmp_path):
    root = shutil.copytree(FIXTURE, tmp_path / "fixture")
    folder = root / "theorems" / SLUG
    initial = read_json(folder / "record.json")
    proof = b"theorem fixture : True := by trivial\n"
    paths = apply(root, SLUG, "First-Player", 11, TIMESTAMP, proof, RESULT)
    assert {path.relative_to(root).as_posix() for path in paths} == {
        f"theorems/{SLUG}/Record.lean", f"theorems/{SLUG}/record.json",
        "data/history.jsonl", "data/leaderboard.json",
    }
    first = dict(score=19, holder="first-player", pr=11, utc=TIMESTAMP)
    assert read_json(folder / "record.json") == first
    assert (folder / "Record.lean").read_bytes() == proof
    after_first = files(root)
    for score in [19, 27]:
        assert apply(root, SLUG, "tie-player", 15, TIMESTAMP, b"ignored",
                     dict(RESULT, score=score)) == []
        assert files(root) == after_first

    apply(root, SLUG, "Second-Player", 21, TIMESTAMP, proof, dict(RESULT, score=7))
    second = dict(score=7, holder="second-player", pr=21, utc=TIMESTAMP)
    assert read_history(root / "data" / "history.jsonl") == [
        dict(slug=SLUG, previous=initial, **first),
        dict(slug=SLUG, previous=first, **second),
    ]
    assert read_json(root / "data" / "leaderboard.json") == [
        dict(login="second-player", records_held=1, records_ever_set=1, characters_saved=12),
        dict(login="first-player", records_held=0, records_ever_set=1, characters_saved=7),
        dict(login="fixture-player", records_held=0, records_ever_set=1, characters_saved=0),
    ]


def test_mismatched_statement_never_writes(tmp_path):
    root = shutil.copytree(FIXTURE, tmp_path / "fixture")
    before = files(root)
    with pytest.raises(ValueError, match="Statement hash"):
        apply(root, SLUG, "someone", 11, TIMESTAMP, b"proof", dict(RESULT, statement_hash="0" * 64))
    assert files(root) == before


def run_build(root, out):
    subprocess.run([sys.executable, ROOT / "site" / "build.py", "--root", root,
                    "--out", out], check=True)


def test_site_and_svg_are_deterministic(tmp_path):
    first, second = tmp_path / "first", tmp_path / "second"
    run_build(FIXTURE, first)
    run_build(FIXTURE, second)
    generated = files(first)
    assert generated == files(second)
    path = f"theorems/{SLUG}/record.svg"
    assert generated[path] == (ROOT / "examples" / "card-example.svg").read_bytes()
    assert b"Infinitely many primes" in generated["index.html"]
    assert b'users/fixture-player/' in generated["index.html"]
    assert b"26" in generated["index.html"]
    assert b"Record history" in generated[f"theorems/{SLUG}/index.html"]
    assert b"1 held" in generated["users/fixture-player/index.html"]

    record = read_json(FIXTURE / "theorems" / SLUG / "record.json")
    statement = (FIXTURE / "theorems" / SLUG / "Statement.lean").read_bytes()
    proof = (FIXTURE / "theorems" / SLUG / "Record.lean").read_text()
    raw_body = proof.split(":=", 1)[1].split("--", 1)[0]
    assert sum(not c.isspace() for c in raw_body) == record["score"] == 26
    assert hashlib.sha256(statement).hexdigest() == RESULT["statement_hash"]

    svg = ET.fromstring(generated[path])
    assert (svg.attrib["width"], svg.attrib["height"]) == ("1200", "675")
    texts = [element.text for element in svg.findall(".//{http://www.w3.org/2000/svg}text")]
    assert "26" in texts
    assert "@fixture-player" in texts
    assert "2026-11-27" in texts
    assert any("Nat.exists_infinite_primes -- < & >" in text for text in texts)
    assert b"&lt; &amp; &gt;" in generated[path]
