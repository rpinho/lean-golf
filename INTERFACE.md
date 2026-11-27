# Lean Golf interface (fixed; both builds code to this)

Toolchain leanprover/lean4:v4.33.1, Mathlib v4.33.1 (rev 0df444a360, lake-manifest.json). Never change the pins.

theorems/<slug>/
  theorem.json   {"slug", "title", "name": "<Lean decl name, e.g. LeanGolf.inf_primes>", "imports": ["Mathlib.X", ...],
                  "forbidden": ["<constants the proof may not reference directly, e.g. Nat.exists_infinite_primes>"],
                  "statement_hash": "<sha256 the checker prints for Statement.lean>",
                  "source": "<where the statement comes from>", "added_utc": "..."}
  Statement.lean the exact statement: `import ...` lines, then `theorem <name> : <type> := by sorry`.
  Record.lean    the current record proof (a full file: same imports, same theorem line, real proof).
  record.json    {"score": int, "holder": "<login>", "pr": N|null, "utc": "..."}

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

Score (default `score_v1`, pluggable): count of non-whitespace characters in the proof after `:=`, comments stripped. Lower is
better; a submission counts only when strictly lower than the record (ties earn nothing).
