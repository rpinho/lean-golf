# Lean Golf

I made Lean Golf, a leaderboard for the shortest [Lean 4](https://lean-lang.org/) proofs: 2,019 open theorems from miniF2F, PutnamBench, Compfiles and ProofNet. [Leaderboard and theorem catalog](https://rpinho.github.io/lean-golf/)

## 60-second start

Once Lean and Mathlib are ready, try proving that 71 leaves remainder 2 when
divided by 3. Check the [theorem page](https://rpinho.github.io/lean-golf/theorems/minif2f-mathd_numbertheory_81/)
to see whether it is still open. You can pick another open theorem from the
catalog if someone has already solved it.

On Apple Silicon, use the native Lean check. On x86, Docker also works.
See [AGENTS.md](AGENTS.md) for both setup paths.

Clone the project. Replace `YOUR_GITHUB_LOGIN` with your GitHub login.

```sh
git clone https://github.com/rpinho/lean-golf.git
cd lean-golf
git switch -c golf-81
slug=minif2f-mathd_numbertheory_81
login=YOUR_GITHUB_LOGIN
proof="submissions/$slug/$login.lean"
cat "theorems/$slug/Statement.lean"
mkdir -p "submissions/$slug"
cat > "$proof" <<'LEAN'
import Mathlib

theorem LeanGolf.minif2f.mathd_numbertheory_81 : 71 % 3 = 2 := by decide
LEAN
lake exe golfcheck "theorems/$slug" "$proof"
```

The checker should print `"valid": true` and score 8. For a different
theorem, copy the allowed imports and exact declaration from its
`Statement.lean`. The checker supplies the context between them. See
[AGENTS.md](AGENTS.md) for setup, Docker, and the proof rules.

Fork the project on GitHub. Commit only your submission file, push the branch
to your fork, then use **Compare & pull request** to open a PR against
`rpinho/lean-golf:main`. A first-time fork submission may need a maintainer
to approve the Actions run.

```sh
git add "$proof"
git commit -m "Add proof for $slug"
git remote add fork "https://github.com/$login/lean-golf.git"
git push -u fork HEAD
```

The first valid proof of an open theorem sets its record, and a shorter proof
beats it. The score counts non-whitespace characters after `:=` once comments
are removed. The leaderboard tracks records held, records ever set, and
characters saved. Each recorded theorem has a history and an SVG card.

## Theorem sources

The catalog contains 2,030 theorem packets. I imported 2,020 alongside the
ten seeds. The first community record left 2,019 open. The
[leaderboard](https://rpinho.github.io/lean-golf/) shows the current count.

The imports include 488 miniF2F, 672 PutnamBench, 534 Compfiles, and 326 ProofNet
statements. Each packet credits its pinned source. [Source credits and licenses](NOTICES.md) · [Import verification](docs/import-1127/REPORT.md)

## How submissions run

A fork PR gets a read-only check and a result summary. A verifier on the
default branch checks the exact submitted file offline. The writer rechecks
the PR, squash-merges verified improvements, and publishes the record.
[Security model](SECURITY.md)

Maintainers can add theorem packets with a PR. [Contributing](CONTRIBUTING.md) · [Repository setup](docs/MAINTAINERS.md)
