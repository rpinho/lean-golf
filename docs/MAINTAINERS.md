# Lean Golf maintainers

## Repository setup

1. Enable squash merging and GitHub Pages from GitHub Actions. The writer job's
   token needs permission to squash-merge submissions and commit record
   updates under the default branch rules.
2. Run **Checker image** from the default branch to build the pinned Lean and
   Mathlib image. Set the GHCR package visibility to Public so both read-only
   check jobs can pull it. The workflow summary records the image size.
3. Run **Publish leaderboard** from the default branch for the first Pages
   build. Later deployments follow theorem or site changes and record updates.

The first image build and end-to-end same-repository submission already ran.
The check took 2m56s. Verification and publication took 3m48s. The check and
verifier jobs each have a 12-minute timeout. A cold image pull depends on the
runner's network and available disk. [Image build](https://github.com/rpinho/lean-golf/actions/runs/46079228967) · [Check](https://github.com/rpinho/lean-golf/actions/runs/46083365066) · [Verify and publish](https://github.com/rpinho/lean-golf/actions/runs/46083634559)

GitHub may hold a first-time fork contributor's check for approval. A
maintainer can approve it from the pull request. The workflow that writes
records must be on the default branch. See [SECURITY.md](../SECURITY.md) for
the check, verification and publication steps.

Build the site locally with `python3 site/build.py`. The
[example record card](../examples/card-example.svg) is 1200 × 675.
