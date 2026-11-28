Read AGENTS.md in https://github.com/rpinho/lean-golf, pick a theorem, and set or beat its record.

Use one account per person and one file per user per theorem. Put it at
`submissions/<slug>/<your GitHub login>.lean`. A submission PR changes exactly that
one file, at most 64 KB. Use only imports listed in `theorem.json`. Copy the exact
theorem declaration from `Statement.lean`, including its name and type across
all lines, and replace the proof after `:=`. The checker automatically supplies
the trusted statement context between the imports and the declaration.

Score counts non-whitespace characters in the proof after comments are stripped.
An open theorem's first valid proof sets the record. A strictly lower score
beats an existing record.

The interface bans `sorry`, `admit`, `native_decide`, `Lean.ofReduceBool`, `axiom`,
`opaque`, `macro`, `macro_rules`, `syntax`, `notation`, `infix`, `prefix`, `postfix`,
`elab`, `run_cmd`, `run_tac`, `run_elab`, `#eval`, `#exit`, `set_option`,
`attribute` and `@[...]` attributes, `implemented_by`, `extern`, `unsafe`,
`partial`, and `namespace`, `section`, `open`, `variable`, or `universe` lines.
It accepts only the single theorem declaration and dependencies on the axioms
`propext`, `Classical.choice`, and `Quot.sound`. Direct references to constants
in `theorem.json`'s `forbidden` list are also banned.

Run the check from the repository root. Replace `SLUG` and `LOGIN` with your
theorem slug and GitHub login.

### Native Lean

Use native Lean on Apple Silicon. You need Git, Python 3, a C compiler
(Xcode Command Line Tools on macOS), and [elan](https://github.com/leanprover/elan).
If you already have elan, skip the installer. On macOS, raise the current
shell's open-file limit for the Mathlib cache unpacker.

```sh
curl -fsSL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh |
  sh -s -- -y --no-modify-path --default-toolchain none
export PATH="$HOME/.elan/bin:$PATH"
elan toolchain install "$(cat lean-toolchain)"
if [ "$(uname -s)" = Darwin ]; then ulimit -Sn 4096; fi
lake exe cache get
lake exe golfcheck theorems/SLUG submissions/SLUG/LOGIN.lean
```

The first setup downloads Lean and Mathlib and takes several minutes.
Refresh the toolchain and cache when the pinned versions change.

### Docker

The published image is Linux amd64. Allow about 20 GiB of free space for
a cold pull with Docker's containerd image store. On a small Ubuntu runner,
the [classic Docker image store](https://docs.docker.com/engine/storage/containerd/)
can fit the same image in less space.

Pull the image before going offline. The checker builds from your checkout
using the image's pinned dependencies.

```sh
export GITHUB_REPOSITORY=rpinho/lean-golf
docker pull "$(bash scripts/image-ref.sh)"
docker run --rm --network none --cap-drop ALL --security-opt no-new-privileges \
  --mount "type=bind,src=$PWD/LeanGolf,dst=/opt/lean-golf/LeanGolf,readonly" \
  --mount "type=bind,src=$PWD/LeanGolf.lean,dst=/opt/lean-golf/LeanGolf.lean,readonly" \
  --mount "type=bind,src=$PWD/Golfcheck,dst=/opt/lean-golf/Golfcheck,readonly" \
  --mount "type=bind,src=$PWD/scripts,dst=/opt/lean-golf/scripts,readonly" \
  --mount "type=bind,src=$PWD/theorems,dst=/opt/lean-golf/theorems,readonly" \
  --mount "type=bind,src=$PWD/submissions/SLUG/LOGIN.lean,dst=/Submission.lean,readonly" \
  "$(bash scripts/image-ref.sh)" lake exe golfcheck theorems/SLUG /Submission.lean
```

The pinned toolchain, file format, and result schema are in [INTERFACE.md](INTERFACE.md).
