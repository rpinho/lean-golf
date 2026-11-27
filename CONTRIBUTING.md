# Adding a theorem

Open a maintainer PR adding a folder `theorems/<slug>/`. Use a lowercase slug
with letters, digits, hyphens, or underscores. Include two files for an open
theorem.

- `theorem.json` gives the title, declaration name, allowed imports, blocked
  constants, checker-produced statement hash, source credit, and UTC date.
- `Statement.lean` contains the allowed imports, any trusted statement context,
  and the reference theorem ending in `:= by sorry`.

For a seeded record, also include these two files.
- `Record.lean` contains the initial proof of exactly that theorem.
- `record.json` gives the checker score, initial holder, `pr: null`, and UTC date.

Run `lake exe golfcheck --statement theorems/<slug>` with the pinned toolchain.
Set `statement_hash` to the reported hash. For a seed, also run
`lake exe golfcheck theorems/<slug> theorems/<slug>/Record.lean` and verify that
its score and statement hash match the JSON files. Credit the source of the
statement and any borrowed proof method.
Choose a statement and import list that leave room for shorter proofs.

See [INTERFACE.md](INTERFACE.md) for schemas and
[AGENTS.md](AGENTS.md) for submission rules.
