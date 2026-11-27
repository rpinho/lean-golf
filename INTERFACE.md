# Lean Golf interface (fixed; both builds code to this)

Toolchain leanprover/lean4:v4.33.1, Mathlib v4.33.1 (rev 0df444a360, lake-manifest.json). Never change the pins.

theorems/<slug>/
  theorem.json   {"slug", "title", "name": "<Lean decl name, e.g. LeanGolf.inf_primes>", "imports": ["Mathlib.X", ...],
                  "forbidden": ["<constants the proof may not reference directly, e.g. Nat.exists_infinite_primes>"],
                  "statement_hash": "<sha256 the checker prints for Statement.lean>",
                  "source": "<where the statement comes from>", "added_utc": "..."}
                  Imported packets also include "source_url", "license", "credit", and "difficulty".
  Statement.lean the exact statement: `import ...` lines, optional trusted context, and the theorem ending in `:= by sorry`.
  Record.lean    optional current record proof (a full submission file).
  record.json    optional {"score": int, "holder": "<login>", "pr": N|null, "utc": "..."}

An open theorem has just `theorem.json` and `Statement.lean`. When context is present, the checker reads it from the
trusted reference and prepends it after the submitted imports. Copy the theorem declaration starting on its own line,
including an explicit `_root_.` qualifier when present. The reference context can supply namespace resolution,
scoped notation, variables, and data definitions.

submissions/<slug>/<github-login>.lean
  One file per user per theorem: `import` lines from theorem.json's list (a subset is fine, nothing else), then exactly
  `theorem <name> : <type> := <proof>`.

Checker CLI (built by the core job): `lake exe golfcheck theorems/<slug> FILE.lean` prints one JSON line, exit 0 valid / 1 invalid:
  {"valid": bool, "score": int|null, "statement_hash": "...", "axioms": [...], "reason": "..."}

Valid means: the source passes the lint below; it compiles; the declared constant's type is identical (Expr equality) to the
reference statement's type; the axioms it depends on are a subset of {propext, Classical.choice, Quot.sound}; it references no
forbidden constant directly.

Source lint (before compiling): only `import` of modules in theorem.json; no sorry, admit, native_decide, Lean.ofReduceBool,
axiom, opaque, macro, macro_rules, syntax, notation, infix/prefix/postfix, elab, run_cmd, run_tac, run_elab, #eval, #exit,
set_option, attribute or @[...] attributes, implemented_by, extern, unsafe, partial, namespace/section/open/variable/universe
lines, or any declaration other than the one theorem. Max 64 KB.

Score (default `score_v1`, pluggable): count of non-whitespace characters in the proof after `:=`, comments stripped. The first
valid proof sets an open theorem's record. For a recorded theorem, a submission counts when strictly lower than the record.

Maintainers can run `lake exe golfcheck --statement theorems/<slug>` to check an exact statement packet and print the
statement hash. A successful authoring check reports a null score, since it checks the reference placeholder and its type.
