#!/usr/bin/env python3
"""Publish exact verified proof scores and derive the leaderboard."""
import argparse
from collections import defaultdict
import json
from pathlib import Path
import re


SLUG = re.compile(r"[a-z0-9][a-z0-9_-]*")
LOGIN = re.compile(r"[A-Za-z0-9](?:[A-Za-z0-9-]{0,38})")
DIGEST = re.compile(r"[0-9a-f]{64}")


def read_json(path):
    return json.loads(path.read_text(encoding="utf-8"))


def write_json(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
                    encoding="utf-8")


def read_history(path):
    if path.exists():
        return [json.loads(line) for line in path.read_text(encoding="utf-8").splitlines()]
    return []


def characters_saved(event):
    previous = event["previous"]
    return 0 if previous is None else previous["score"] - event["score"]


def totals(records, history):
    users = defaultdict(lambda: dict(records_held=0, records_ever_set=0, characters_saved=0))
    initial = records.copy()
    for event in reversed(history):
        if event["previous"] is None:
            initial.pop(event["slug"], None)
        else:
            initial[event["slug"]] = event["previous"]
    for record in initial.values():
        users[record["holder"].lower()]["records_ever_set"] += 1
    for record in records.values():
        users[record["holder"].lower()]["records_held"] += 1
    for event in history:
        user = users[event["holder"].lower()]
        user["records_ever_set"] += 1
        user["characters_saved"] += characters_saved(event)
    return sorted(
        (dict(login=login, **counts) for login, counts in users.items()),
        key=lambda row: (-row["records_held"], -row["records_ever_set"],
                         -row["characters_saved"], row["login"]),
    )


def current_records(root):
    return {path.parent.name: read_json(path)
            for path in sorted((root / "theorems").glob("*/record.json"))}


def apply(root, slug, holder, pr, utc, proof, result):
    if not (SLUG.fullmatch(slug) and LOGIN.fullmatch(holder)):
        raise ValueError("Invalid theorem slug or GitHub login")
    if isinstance(pr, bool) or not isinstance(pr, int) or pr < 1:
        raise ValueError("Invalid pull request number")
    score = result["score"]
    if result["valid"] is not True or type(score) is not int or score < 0:
        raise ValueError("Expected a verified score")
    folder = root / "theorems" / slug
    if result["statement_hash"] != read_json(folder / "theorem.json")["statement_hash"]:
        raise ValueError("Statement hash differs from the checked statement")

    records = current_records(root)
    previous = records.get(slug)
    if previous is not None and score >= previous["score"]:
        return []

    data = root / "data"
    history_path = data / "history.jsonl"
    history = read_history(history_path)
    record = dict(score=score, holder=holder.lower(), pr=pr, utc=utc)
    history.append(dict(slug=slug, previous=previous, **record))
    records[slug] = record

    data.mkdir(exist_ok=True)
    proof_path = folder / "Record.lean"
    record_path = folder / "record.json"
    leaderboard = data / "leaderboard.json"
    proof_path.write_bytes(proof)
    write_json(record_path, record)
    history_path.write_text("".join(json.dumps(event, ensure_ascii=False, sort_keys=True) + "\n"
                                    for event in history), encoding="utf-8")
    write_json(leaderboard, totals(records, history))
    return [proof_path, record_path, history_path, leaderboard]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("slug")
    parser.add_argument("holder")
    parser.add_argument("pr", type=int)
    parser.add_argument("utc", help="Fixed UTC timestamp for this record")
    parser.add_argument("proof", type=Path)
    parser.add_argument("result", type=Path)
    parser.add_argument("--root", type=Path, default=Path.cwd())
    args = parser.parse_args()
    paths = apply(args.root, args.slug, args.holder, args.pr, args.utc,
                  args.proof.read_bytes(), read_json(args.result))
    print("Record updated." if paths else "Current record stands.")


if __name__ == "__main__":
    main()
