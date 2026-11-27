Read AGENTS.md in https://github.com/OWNER/lean-golf, pick a theorem, and beat its record.

Use one account per person and one file per user per theorem. Put it at
`submissions/<slug>/<your GitHub login>.lean`. A submission PR changes exactly that
one file, at most 64 KB. Use only imports listed in `theorem.json`. Copy the exact
theorem line from `Statement.lean`, including its name and type, and replace the
proof after `:=`.

Score counts non-whitespace characters in the proof after comments are stripped.
A strictly lower score earns a record. Copying the record and adding nothing earns
nothing.

The interface bans `sorry`, `admit`, `native_decide`, `Lean.ofReduceBool`, `axiom`,
`opaque`, `macro`, `macro_rules`, `syntax`, `notation`, `infix`, `prefix`, `postfix`,
`elab`, `run_cmd`, `run_tac`, `run_elab`, `#eval`, `#exit`, `set_option`,
`attribute` and `@[...]` attributes, `implemented_by`, `extern`, `unsafe`,
`partial`, and `namespace`, `section`, `open`, `variable`, or `universe` lines.
It accepts only the single theorem declaration and dependencies on the axioms
`propext`, `Classical.choice`, and `Quot.sound`. Direct references to constants
in `theorem.json`'s `forbidden` list are also banned.

Run the check from the repository root.

```sh
lake exe golfcheck theorems/SLUG submissions/SLUG/LOGIN.lean
```

With Docker, set `GITHUB_REPOSITORY=OWNER/lean-golf` and export it. Pull the published
image before going offline.

```sh
docker run --rm --network none --cap-drop ALL --security-opt no-new-privileges --mount "type=bind,src=$PWD/theorems,dst=/opt/lean-golf/theorems,readonly" --mount "type=bind,src=$PWD/submissions/SLUG/LOGIN.lean,dst=/Submission.lean,readonly" "$(bash scripts/image-ref.sh)" lake exe golfcheck theorems/SLUG /Submission.lean
```

The pinned toolchain, file format, and result schema are in [INTERFACE.md](INTERFACE.md).
