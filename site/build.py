#!/usr/bin/env python3
"""Render the public leaderboard, theorem and user pages, and SVG cards."""
import argparse
from html import escape
from pathlib import Path
import re
import shutil
import sys
import textwrap

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))
from records import current_records, read_history, read_json, totals


REPO = "https://github.com/OWNER/lean-golf"
STYLESHEET = Path(__file__).with_name("style.css")
INVALID_XML = re.compile(r"[\x00-\x08\x0b\x0c\x0e-\x1f\ufffe\uffff]")


def html_page(title, prefix, body):
    return f"""<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{escape(title)}</title>
<link rel="stylesheet" href="{prefix}style.css">
</head>
<body>
<header><div class="wrap masthead">
  <a class="brand" href="{prefix}">lean-golf</a>
  <span>Lean 4 proof leaderboard</span>
</div></header>
<main class="wrap">{body}</main>
</body>
</html>
"""


def table(headers, rows):
    head = "".join(f'<th scope="col">{escape(label)}</th>' for label in headers)
    body = "".join("<tr>" + "".join(f"<td>{cell}</td>" for cell in row) + "</tr>"
                   for row in rows)
    return (f'<div class="table-scroll"><table><thead><tr>{head}</tr></thead>'
            f"<tbody>{body}</tbody></table></div>")


def user_link(login, prefix):
    return f'<a href="{prefix}users/{escape(login.lower())}/">@{escape(login)}</a>'


def theorem_link(slug, title, prefix):
    return f'<a href="{prefix}theorems/{escape(slug)}/">{escape(title)}</a>'


def date(utc):
    return f'<time datetime="{escape(utc)}">{escape(utc[:10])}</time>'


def code(source):
    return f"<pre><code>{escape(source)}</code></pre>"


def record_rows(records, titles, prefix):
    return [(theorem_link(slug, titles[slug], prefix), f'<strong>{record["score"]}</strong>',
             user_link(record["holder"], prefix), date(record["utc"]))
            for slug, record in records.items()]


def write_page(path, title, prefix, body):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(html_page(title, prefix, body), encoding="utf-8")


def theorem_source(folder):
    statement = (folder / "Statement.lean").read_text(encoding="utf-8").strip()
    record = (folder / "Record.lean").read_text(encoding="utf-8").strip()
    declaration = re.split(r"(?m)^\s*(?=theorem\s)", statement, maxsplit=1)[-1]
    declaration = re.sub(r"\s*:=\s*by\s+sorry\s*$", "", declaration)
    record_body = re.split(r"(?m)^\s*(?=theorem\s)", record, maxsplit=1)[-1]
    if record_body.startswith(declaration) and record_body[len(declaration):].lstrip().startswith(":="):
        proof = record_body[len(declaration):].lstrip()[2:].lstrip()
    else:
        proof = record_body
    return declaration, proof, record


def xml(text):
    return escape(INVALID_XML.sub("\ufffd", str(text)))


def clip(text, width):
    return text if len(text) <= width else text[:width - 1] + "…"


def lines(text, width, limit):
    wrapped = []
    for line in text.expandtabs(4).splitlines():
        leading = min(len(line) - len(line.lstrip()), width // 4)
        indent = " " * leading
        wrapped.extend(textwrap.wrap(line.lstrip(), width=width, initial_indent=indent,
                                     subsequent_indent=indent + "  ", break_on_hyphens=False) or [""])
    if len(wrapped) > limit:
        return wrapped[:limit - 1] + ["…"]
    return wrapped


def svg_card(title, statement, proof, record):
    def block(source, y, limit):
        return "".join(f'<text x="88" y="{y + 29 * i}" xml:space="preserve">{xml(line)}</text>\n'
                       for i, line in enumerate(lines(source, 78, limit)))

    holder = record["holder"]
    day = record["utc"][:10]
    label = f"{title}, {record['score']} characters, held by {holder}, {day}"
    return f"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 675" width="1200" height="675" role="img" aria-labelledby="title description">
<title id="title">{xml(label)}</title>
<desc id="description">Lean Golf theorem record. Statement: {xml(statement)}. Proof: {xml(proof)}.</desc>
<rect width="1200" height="675" fill="#101917"/>
<path d="M0 0H1200V10H0Z" fill="#78f4bc"/>
<g font-family="system-ui, sans-serif">
  <text x="64" y="68" fill="#78f4bc" font-size="28" font-weight="700">lean-golf</text>
  <text x="1136" y="66" fill="#a9bbb4" font-size="17" text-anchor="end">{xml(REPO.removeprefix("https://"))}</text>
  <text x="64" y="141" fill="#f2f7f4" font-size="47" font-weight="750">{xml(clip(title, 37))}</text>
  <text x="1136" y="143" fill="#78f4bc" font-size="58" font-weight="750" text-anchor="end">{xml(record["score"])}</text>
  <text x="1136" y="169" fill="#a9bbb4" font-size="17" text-anchor="end">characters</text>
  <text x="64" y="197" fill="#a9bbb4" font-size="17" letter-spacing="2">STATEMENT</text>
  <text x="64" y="356" fill="#a9bbb4" font-size="17" letter-spacing="2">RECORD PROOF</text>
  <text x="64" y="628" fill="#f2f7f4" font-size="27" font-weight="650">@{xml(holder)}</text>
  <text x="1136" y="628" fill="#a9bbb4" font-size="24" text-anchor="end">{xml(day)}</text>
</g>
<rect x="64" y="210" width="1072" height="120" rx="10" fill="#1b2824" stroke="#394e45"/>
<rect x="64" y="369" width="1072" height="215" rx="10" fill="#1b2824" stroke="#394e45"/>
<g fill="#e1efe7" font-family="ui-monospace, SFMono-Regular, Consolas, monospace" font-size="21">
{block(statement, 241, 3)}{block(proof, 400, 6)}</g>
</svg>
"""


def build(root, out):
    records = current_records(root)
    history = read_history(root / "data" / "history.jsonl")
    theorems = root / "theorems"
    titles = {slug: read_json(theorems / slug / "theorem.json")["title"] for slug in records}
    users = totals(records, history)
    out.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(STYLESHEET, out / "style.css")
    (out / ".nojekyll").write_text("", encoding="utf-8")
    board = table(("Theorem", "Characters", "Holder", "Date"),
                  record_rows(records, titles, "")) if records else "<p>No theorems yet.</p>"
    player_rows = [(user_link(row["login"], ""), str(row["records_held"]),
                    str(row["records_ever_set"]), str(row["characters_saved"])) for row in users]
    players = table(("Player", "Held", "Ever set", "Characters saved"), player_rows) if users else ""
    write_page(out / "index.html", "Lean Golf", "", f"""
<h1>The leaderboard</h1>
<p>Shortest Lean 4 proofs. Scores count non-whitespace proof characters after comments are stripped.</p>
<section aria-labelledby="records"><h2 id="records">Theorem records</h2>{board}</section>
<section aria-labelledby="players"><h2 id="players">Players</h2>{players or "<p>No players yet.</p>"}</section>
""")

    for slug, record in records.items():
        title = titles[slug]
        folder = theorems / slug
        target = out / "theorems" / slug
        statement, proof, full_record = theorem_source(folder)
        events = [event for event in history if event["slug"] == slug]
        event_rows = reversed([events[0]["previous"], *events] if events else [record])
        changes = table(("Holder", "Characters", "Date"), [
            (user_link(event["holder"], "../../"), str(event["score"]), date(event["utc"]))
            for event in event_rows
        ])
        write_page(target / "index.html", f"{title} · Lean Golf", "../../", f"""
<h1>{escape(title)}</h1>
<p class="record"><strong>{record["score"]}</strong> characters · {user_link(record["holder"], "../../")} · {date(record["utc"])}</p>
<section><h2>Statement</h2>{code(statement)}</section>
<section><h2>Record proof</h2>{code(full_record)}<p><a href="record.svg">Record card (SVG)</a></p></section>
<section><h2>Record history</h2>{changes}</section>
""")
        (target / "record.svg").write_text(svg_card(title, statement, proof, record), encoding="utf-8")

    for user in users:
        login = user["login"]
        held = {slug: record for slug, record in records.items() if record["holder"].lower() == login}
        rows = [(theorem_link(event["slug"], titles[event["slug"]], "../../"), str(event["score"]),
                 str(event["previous"]["score"] - event["score"]), date(event["utc"]))
                for event in reversed(history)
                if event["holder"].lower() == login and event["slug"] in titles]
        current = table(("Theorem", "Characters", "Holder", "Date"),
                        record_rows(held, titles, "../../")) if held else "<p>No current records.</p>"
        changes = (table(("Theorem", "Characters", "Saved", "Date"), rows)
                   if rows else "<p>No recorded improvements.</p>")
        write_page(out / "users" / login / "index.html", f"@{login} · Lean Golf", "../../", f"""
<h1>@{escape(login)}</h1>
<p class="record">{user["records_held"]} held · {user["records_ever_set"]} ever set · {user["characters_saved"]} characters saved</p>
<section><h2>Current records</h2>{current}</section>
<section><h2>Improvements</h2>{changes}</section>
""")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    repo = Path(__file__).resolve().parents[1]
    parser.add_argument("--root", type=Path, default=repo)
    parser.add_argument("--out", type=Path, default=repo / "site" / "dist")
    args = parser.parse_args()
    build(args.root, args.out)


if __name__ == "__main__":
    main()
