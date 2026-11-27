# Lean Golf checker

Run from the repository root with the pinned Lean and prebuilt Mathlib checkout
available to Lake, and with Python 3.9 or newer.

```sh
lake build golfcheck
lake exe golfcheck theorems/cantor theorems/cantor/Record.lean
```

The executable writes one JSON line with `valid`, `score`, `statement_hash`,
`axioms` and `reason`. Exit 0 means the proof is valid. Exit 1 means it failed a
check. A valid proof has an empty reason. A rejection has a null score. The
statement hash is empty when the checker fails before reading the reference
type, and the axiom list is empty when dependency collection has yet to run.

1. **Read and lint.** The checker reads at most 65,536 bytes, decodes UTF-8 and
   removes line comments and nested block comments while preserving token
   boundaries and line layout. It rejects strings and guillemet-quoted identifiers. Lean parses
   the header and loads the permitted imports for their syntax. It requires
   exactly one plain theorem with the specified name and a `:=` body, and
   rejects the banned tokens and commands in the interface, along with
   related elaboration and file-reading forms such as `by_elab` and `include_str`.
2. **Compile.** If a reference packet has a preamble between its imports and
   theorem, the parser uses its trusted context to read the submission. After
   linting, the checker inserts that context after the submitted imports.
   The checker runs the pinned Lean compiler separately on the prepared
   submission and trusted `Statement.lean` in a fresh directory
   named with the submission SHA-256. The stages share a 120-second deadline.
   Lean runs with one compiler thread. Its own memory setting (16 GiB) sits above
   the container's 10 GB memory limit, which bounds real use; a check peaks near
   1.2 GB. There is no address-space limit, because Lean reserves large virtual
   regions. The checker kills and reaps the worker
   process group on timeout and clears its scratch directory.
3. **Verify.** A separate Lean process reads both compiled theorem declarations.
   It compares their expression structure, including binder annotations, after
   canonicalizing bound variable and universe names and removing elaboration metadata. It replays
   the submission declarations in a fresh environment of the pinned imports,
   then collects transitive axioms and permits only `propext`,
   `Classical.choice` and `Quot.sound`. It checks forbidden references in the
   proof and any submission-generated dependencies, stopping at imported
   declarations.
4. **Fingerprint and score.** The statement hash is SHA-256 of the UTF-8 bytes
   of the universe parameter count, a newline and Lean 4.33.1's fixed
   `Expr.toString` rendering of the canonical reference type. When supplied,
   the hash in `theorem.json` must match. A blank hash permits authoring a new
   packet. `score_v1` counts non-whitespace Unicode code points after the
   parsed `:=`. On an open theorem, a verified first proof creates
   `record.json` and `Record.lean`. Later records require strictly lower
   scores. The checker can validate incumbent proofs and ties.

The authoring command `lake exe golfcheck --statement THEOREM_DIR` compiles
the reference with its `by sorry` placeholder, lints the submission template,
and compiles a temporary copy to compare its elaborated type with the
reference. It replays the reference declarations, checks axioms reachable
from the type and context, and returns the canonical hash used by submission
checking. The importer can reuse an import environment for packets with
the same imports. Each packet gets a new elaboration state and a separate
kernel replay. Recursive packet definitions contribute their safe kernel
definitions to the replay. Lean's generated executable implementations
stay outside the certificate.

## Trust and coverage

The runner must provide trusted theorem packets, a pinned toolchain and
imports, and isolation for elaborating untrusted submissions. The lint and
resource limits address the source rules and bounded execution. They provide
no OS filesystem or network isolation. Forbidden declarations used only
inside an imported dependency are outside the direct-reference policy.
The checker verifies each proof certificate and its score, while optimality
and leaderboard state are separate questions.
