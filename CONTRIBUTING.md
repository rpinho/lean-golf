# Adding a theorem

Open a maintainer PR adding a folder `theorems/<slug>/`. Use a lowercase slug
with letters, digits, hyphens, or underscores. Include these four files.

- `theorem.json` gives the title, declaration name, allowed imports, blocked
  constants, checker-produced statement hash, source credit, and UTC date.
- `Statement.lean` contains the allowed imports and the reference theorem
  ending in `:= by sorry`.
- `Record.lean` contains the initial proof of exactly that theorem.
- `record.json` gives the checker score, initial holder, `pr: null`, and UTC date.

Run `lake exe golfcheck theorems/<slug> theorems/<slug>/Record.lean` with the
pinned toolchain. Verify that its score and statement hash match the JSON
files. Credit the source of the statement and any borrowed proof method.
Choose a statement and import list that leave room for shorter proofs.

See [INTERFACE.md](INTERFACE.md) for schemas and
[AGENTS.md](AGENTS.md) for submission rules.
