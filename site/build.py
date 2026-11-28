#!/usr/bin/env python3
"""Render the public leaderboard, theorem and user pages, and SVG cards."""
import argparse
from collections import defaultdict
from html import escape
from pathlib import Path
import re
import shutil
import sys
import textwrap

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))
from records import characters_saved, current_records, read_history, read_json, totals


REPO = "https://github.com/rpinho/lean-golf"
STYLESHEET = Path(__file__).with_name("style.css")
INVALID_XML = re.compile(r"[\x00-\x08\x0b\x0c\x0e-\x1f\ufffe\uffff]")
PAGE_SIZE = 50


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
    before, declaration = re.split(r"(?m)^(?=theorem\s)", statement, maxsplit=1)
    declaration = re.sub(r"\s*:=\s*by\s+sorry\s*$", "", declaration)
    imports = re.match(r"(?:import [^\n]+\n)*", before)[0]
    context = before[len(imports):].strip()
    return declaration, imports, context


def record_source(folder, declaration):
    record = (folder / "Record.lean").read_text(encoding="utf-8").strip()
    record_body = re.split(r"(?m)^\s*(?=theorem\s)", record, maxsplit=1)[-1]
    if record_body.startswith(declaration) and record_body[len(declaration):].lstrip().startswith(":="):
        proof = record_body[len(declaration):].lstrip()[2:].lstrip()
    else:
        proof = record_body
    return proof, record


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


def catalog_key(label):
    return re.sub(r"[^a-z0-9]+", "-", label.lower()).strip("-")


def catalog_rows(packets, records, prefix):
    for slug, meta in packets:
        record = records.get(slug)
        yield (theorem_link(slug, meta["title"], prefix), escape(meta.get("difficulty", "")),
               f'{record["score"]} characters' if record else "Open")


def build_catalog(out, source, packets, records):
    source_path = f"catalog/{catalog_key(source)}"
    difficulties = defaultdict(list)
    for item in packets:
        difficulty = item[1].get("difficulty", "Unclassified")
        # Readers choose a year first, then see its A/B problem labels together.
        parts = difficulty.split()
        if source == "PutnamBench" and len(parts) == 2:
            for part in parts:
                difficulties[part].append(item)
        else:
            difficulties[difficulty].append(item)
    def pages(path, entries, group=None):
        label = source if group is None else f"{source} · {group}"
        count = (len(entries) + PAGE_SIZE - 1) // PAGE_SIZE
        for index in range(count):
            number = index + 1
            relative = path if index == 0 else f"{path}/page/{number}"
            prefix = "../" * len(relative.split("/"))
            rows = catalog_rows(entries[index * PAGE_SIZE:number * PAGE_SIZE], records, prefix)
            body = table(("Theorem", "Difficulty", "Record"), rows)
            links = []
            for page in range(1, count + 1):
                href = path if page == 1 else f"{path}/page/{page}"
                if page == number:
                    links.append(f'<span aria-current="page">{page}</span>')
                else:
                    links.append(f'<a href="{prefix}{href}/">{page}</a>')
            nav = (f'<nav class="pagination" aria-label="Catalog pages">{" ".join(links)}</nav>'
                   if links else "")
            source_link = f'<a href="{prefix}{source_path}/">All {escape(source)} theorems</a>'
            filter_links = "".join(
                f'<li><a href="{prefix}{source_path}/difficulty/{catalog_key(option)}/">'
                f'{escape(option)}</a></li>' for option in sorted(difficulties)
            )
            filter_nav = (f'<details><summary>Filter by difficulty</summary><ul class="filters">'
                          f"{filter_links}</ul></details>" if group is None else f"<p>{source_link}</p>")
            write_page(out / relative / "index.html", label, prefix, f"""
<h1>{escape(label)}</h1>
<p>{len(entries)} theorems</p>
{filter_nav}
{body}
{nav}
""")

    pages(source_path, packets)
    for group, entries in sorted(difficulties.items()):
        pages(f"{source_path}/difficulty/{catalog_key(group)}", entries, group)


def theorem_credit(meta):
    url = meta.get("source_url", "")
    if not url.startswith("https://"):
        return ""
    source = escape(meta["source"])
    return (f'<p class="theorem-credit"><a href="{escape(url)}">{source}</a>'
            f' · {escape(meta["difficulty"])} · {escape(meta["license"])}'
            f'<br>{escape(meta["credit"])}</p>')


def build(root, out):
    records = current_records(root)
    history = read_history(root / "data" / "history.jsonl")
    theorems = root / "theorems"
    packets = {path.parent.name: read_json(path)
               for path in sorted(theorems.glob("*/theorem.json"))}
    titles = {slug: meta["title"] for slug, meta in packets.items()}
    archive = root / "data" / "statement-archive"
    archived_records = {path.parent.name: read_json(path)
                        for path in sorted(archive.glob("*/record.json"))}
    archived_titles = {slug: read_json(archive / slug / "theorem.json")["title"]
                       for slug in archived_records}
    groups = defaultdict(list)
    seeds = []
    for slug, meta in packets.items():
        if meta.get("source_url"):
            groups[meta["source"]].append((slug, meta))
        else:
            seeds.append((slug, meta))
    events_by_slug = defaultdict(list)
    for event in history:
        events_by_slug[event["slug"]].append(event)
    archived_events = {(slug, record["utc"], record["pr"]) for slug, record in archived_records.items()}
    for slug, record in archived_records.items():
        entries = events_by_slug[slug]
        for i, entry in enumerate(entries):
            if all(entry.get(key) == value for key, value in record.items()):
                archived_events.update((slug, event["utc"], event["pr"]) for event in entries[:i + 1])
                previous = entries[0]["previous"]
                if previous is not None:
                    archived_events.add((slug, previous["utc"], previous["pr"]))
                break
    users = totals(records, history)
    out.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(STYLESHEET, out / "style.css")
    (out / ".nojekyll").write_text("", encoding="utf-8")
    seed_rows = []
    for slug, meta in seeds:
        if slug in records:
            seed_rows.extend(record_rows({slug: records[slug]}, titles, ""))
        else:
            seed_rows.append((theorem_link(slug, meta["title"], ""), "Open", "", ""))
    board = (table(("Theorem", "Characters", "Holder", "Date"), seed_rows)
             if seed_rows else "")
    group_rows = []
    for source, items in sorted(groups.items()):
        recorded = sum(slug in records for slug, _ in items)
        group_rows.append((f'<a href="catalog/{catalog_key(source)}/">{escape(source)}</a>',
                           str(len(items) - recorded), str(recorded)))
        build_catalog(out, source, items, records)
    catalog = (table(("Source", "Open", "Records set"), group_rows)
               if group_rows else "")
    seed_section = (f'<section aria-labelledby="records"><h2 id="records">Seed theorems</h2>'
                    f'{board}</section>' if board else "")
    group_section = (f'<section aria-labelledby="catalog"><h2 id="catalog">Theorems by source</h2>'
                     f'{catalog}</section>' if catalog else "")
    player_rows = [(user_link(row["login"], ""), str(row["records_held"]),
                    str(row["records_ever_set"]), str(row["characters_saved"])) for row in users]
    players = table(("Player", "Held", "Ever set", "Characters saved"), player_rows) if users else ""
    write_page(out / "index.html", "Lean Golf", "", f"""
<h1>The leaderboard</h1>
<p>Shortest Lean 4 proofs. Scores count non-whitespace proof characters after comments are stripped.</p>
<p class="record"><strong>{len(packets) - len(records)}</strong> open · <strong>{len(records)}</strong> records set</p>
{seed_section}
{group_section}
<section aria-labelledby="players"><h2 id="players">Players</h2>{players or "<p>No players yet.</p>"}</section>
""")

    for slug, meta in packets.items():
        title = titles[slug]
        folder = theorems / slug
        target = out / "theorems" / slug
        statement, imports, context = theorem_source(folder)
        credit = theorem_credit(meta)
        details = (f"<details><summary>Trusted statement context</summary>{code(context)}</details>"
                   if context else "")
        archive_note = ('<p>A past record belongs to an archived statement.</p>'
                        if slug in archived_records else "")
        if slug not in records:
            write_page(target / "index.html", f"{title} · Lean Golf", "../../", f"""
<h1>{escape(title)}</h1>
<p class="record">open: first valid proof sets the record</p>
{archive_note}
{credit}
<section><h2>Statement</h2>{code(imports + statement)}{details}</section>
""")
            continue
        record = records[slug]
        proof, full_record = record_source(folder, statement)
        events = events_by_slug[slug]
        event_rows = reversed([events[0]["previous"], *events] if events else [record])
        changes = table(("Holder", "Characters", "Date"), [
            (user_link(event["holder"], "../../") +
             (" (archived statement)" if (slug, event["utc"], event["pr"]) in archived_events else ""),
             str(event["score"]), date(event["utc"]))
            for event in event_rows if event is not None
        ])
        write_page(target / "index.html", f"{title} · Lean Golf", "../../", f"""
<h1>{escape(title)}</h1>
<p class="record"><strong>{record["score"]}</strong> characters · {user_link(record["holder"], "../../")} · {date(record["utc"])}</p>
{archive_note}
{credit}
<section><h2>Statement</h2>{code(imports + statement)}{details}</section>
<section><h2>Record proof</h2>{code(full_record)}<p><a href="record.svg">Record card (SVG)</a></p></section>
<section><h2>Record history</h2>{changes}</section>
""")
        (target / "record.svg").write_text(svg_card(title, statement, proof, record), encoding="utf-8")

    for user in users:
        login = user["login"]
        held = {slug: record for slug, record in records.items() if record["holder"].lower() == login}
        rows = []
        for event in reversed(history):
            if event["holder"].lower() != login:
                continue
            slug = event["slug"]
            if (slug, event["utc"], event["pr"]) in archived_events:
                theorem = escape(archived_titles[slug]) + " (archived statement)"
            elif slug in titles:
                theorem = theorem_link(slug, titles[slug], "../../")
            else:
                continue
            rows.append((theorem, str(event["score"]), str(characters_saved(event)), date(event["utc"])))
        current = table(("Theorem", "Characters", "Holder", "Date"),
                        record_rows(held, titles, "../../")) if held else "<p>No current records.</p>"
        changes = (table(("Theorem", "Characters", "Saved", "Date"), rows)
                   if rows else "<p>No recorded records.</p>")
        write_page(out / "users" / login / "index.html", f"@{login} · Lean Golf", "../../", f"""
<h1>@{escape(login)}</h1>
<p class="record">{user["records_held"]} held · {user["records_ever_set"]} ever set · {user["characters_saved"]} characters saved</p>
<section><h2>Current records</h2>{current}</section>
<section><h2>Records set</h2>{changes}</section>
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
