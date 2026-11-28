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
from records import apply, read_history, read_json, write_json  # noqa: E402
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


def test_archived_record_is_marked_in_history(tmp_path):
    root = shutil.copytree(FIXTURE, tmp_path / "fixture")
    packet = root / "theorems" / SLUG
    proof = b"theorem prior : True := by trivial\n"
    apply(root, SLUG, "prior-player", 11, TIMESTAMP, proof, RESULT)
    archive = root / "data" / "statement-archive" / SLUG
    archive.mkdir(parents=True)
    shutil.copy2(packet / "theorem.json", archive / "theorem.json")
    for filename in ("record.json", "Record.lean"):
        (packet / filename).rename(archive / filename)
    original = (root / "data" / "history.jsonl").read_bytes()

    out = tmp_path / "site"
    run_build(root, out)
    theorem = (out / "theorems" / SLUG / "index.html").read_text()
    user = (out / "users" / "prior-player" / "index.html").read_text()
    assert "first valid proof sets the record" in theorem
    assert "A past record belongs to an archived statement" in theorem
    assert "Infinitely many primes (archived statement)" in user
    assert (root / "data" / "history.jsonl").read_bytes() == original


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


def test_mixed_catalog_paginates_and_open_theorem_gets_history(tmp_path):
    root = shutil.copytree(FIXTURE, tmp_path / "fixture")
    for number in range(51):
        slug = f"minif2f-example-{number:02}"
        folder = root / "theorems" / slug
        folder.mkdir()
        name = f"LeanGolf.fixture{number}"
        write_json(folder / "theorem.json", {
            "slug": slug, "name": name, "title": f"Example {number}",
            "statement_hash": RESULT["statement_hash"], "source": "miniF2F",
            "source_url": "https://example.org/pinned/Example.lean",
            "license": "MIT", "credit": "Example contributor",
            "difficulty": "imo" if number == 50 else "amc",
        })
        (folder / "Statement.lean").write_text(f"theorem {name} : True := by sorry\n")

    first, second, updated = (tmp_path / name for name in ("first", "second", "updated"))
    run_build(root, first)
    run_build(root, second)
    generated = files(first)
    assert generated == files(second)
    assert b"<strong>51</strong> open" in generated["index.html"]
    assert b"<strong>1</strong> records set" in generated["index.html"]
    assert generated["index.html"].index(b"Seed theorems") < generated["index.html"].index(b"miniF2F")
    all_first = "catalog/minif2f/index.html"
    all_second = "catalog/minif2f/page/2/index.html"
    filtered = "catalog/minif2f/difficulty/imo/index.html"
    assert b"Example 50" not in generated[all_first]
    assert b"catalog/minif2f/page/2/" in generated[all_first]
    assert b"Example 50" in generated[all_second]
    assert b"Example 50" in generated[filtered] and b"Example 49" not in generated[filtered]
    target = "theorems/minif2f-example-50"
    assert b"open: first valid proof sets the record" in generated[f"{target}/index.html"]
    assert f"{target}/record.svg" not in generated

    slug = "minif2f-example-50"
    proof = b"theorem LeanGolf.fixture50 : True := by trivial\n"
    apply(root, slug, "first", 11, TIMESTAMP, proof, RESULT)
    assert read_json(root / "data/leaderboard.json")[0] == {
        "login": "first", "records_held": 1, "records_ever_set": 1, "characters_saved": 0,
    }
    apply(root, slug, "second", 12, TIMESTAMP, proof, dict(RESULT, score=7))
    assert {row["login"]: row["characters_saved"] for row in
            read_json(root / "data/leaderboard.json")} == {"first": 0, "second": 12, "fixture-player": 0}
    run_build(root, updated)
    assert b"<strong>50</strong> open" in (updated / "index.html").read_bytes()
    assert b"<strong>2</strong> records set" in (updated / "index.html").read_bytes()
    assert (updated / target / "record.svg").is_file()
    page = (updated / target / "index.html").read_bytes()
    assert b"Record history" in page and b"@first" in page and b"@second" in page
