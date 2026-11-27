# Lean Golf

A leaderboard for the shortest [Lean 4](https://lean-lang.org/) proofs. Each theorem has a record, a history, and a shareable SVG card. The leaderboard tracks records held, records ever set, and characters saved by each player.

## Enter

1. Pick a theorem from `theorems/` and copy its theorem line from `Statement.lean`.
2. Write the proof in `submissions/<slug>/<your GitHub login>.lean` and run the check in [AGENTS.md](AGENTS.md).
3. Open a pull request containing that one file.

The score is the number of non-whitespace characters in the proof after `:=`, with comments stripped. A new record requires a strictly lower score. Characters saved are the successive score decreases credited to their holders.

Maintainers add theorems with a PR that adds a folder under `theorems/`. See [CONTRIBUTING.md](CONTRIBUTING.md).

## Security model

1. Fork PRs run a read-only check and receive a summary and JSON artifact.
2. The default branch owns a separate verifier triggered when the PR check finishes.
3. The verifier fetches one regular file at the exact PR head and runs the checker offline.
4. The writer rechecks the PR, squash-merges verified improvements, and publishes record data with a branch-head guard.
5. The Pages build reads the default branch's theorem and record data. See [SECURITY.md](SECURITY.md).

## Repository setup

1. Enable squash merging and GitHub Pages from GitHub Actions. Give the repository's Actions token access to squash-merge submissions and commit record updates under the branch rules.
2. Run **Checker image** from the default branch after the checker and seed theorems land. Set the GHCR package visibility to Public so both read-only check jobs can pull it. The workflow records the image size in bytes.
3. Run **Publish leaderboard** from the default branch for the first Pages build. Later deployments run on theorem or site changes and after a record update.

The target is a check in under a minute with the image already available. A cold
GHCR download depends on the runner and can dominate that time. Each check job
has a three-minute limit, including checkout and image pull. The local pinned Lean
installation and Mathlib package tree total roughly 10 GiB, which gives an order
of magnitude for the uncompressed image. The Linux image size, compressed pull
size, and actual check times still need a first Actions run.

Build the site locally with `python3 site/build.py`. See the
[fixture record card](examples/card-example.svg) for the 1200 × 675 SVG format.
