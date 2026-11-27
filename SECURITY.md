# Security

A fork PR controls the definition of the `pull_request` workflow it runs. Treat
its job status, summary, and artifact as untrusted. The only signal the merge
workflow uses is the completion event. An apparent success only schedules a new
check.

The `workflow_run` definition and checker source come from the default branch.
Its verifier has `contents: read` and receives no repository secrets. It resolves
the open PR by the completion event's head SHA and source repository, validates
the changed-file list against the immutable Git tree, and downloads a single
plain Lean file. No fork source checkout or fork artifact enters trusted jobs.
The verify job runs the checker with Docker networking disabled, a read-only
filesystem outside scratch space, resource limits, dropped capabilities, and
no tokens mounted in the container. The Lean lint, type comparison, and axiom
checks are specified in [INTERFACE.md](INTERFACE.md).

Only the publishing job has repository and PR write permissions. It accepts
a receipt from its own verify job, refetches the single file, and confirms the
head, path, and bytes. GitHub's squash API requires the verified head SHA.
A squash imports the submission path without importing the fork's commit
history. The writer confirms the resulting default-branch blob before updating
records. The four record files go into one commit conditional on the current
default-branch SHA. The writer runs no Lean or fork code.

GitHub squashes a PR and updates the records in two operations. If the record
commit fails after a successful squash, rerun the failed publishing job with
its existing verification receipt. It will recognize the completed squash and
recheck the current record. Publishing jobs are serialized. GitHub Actions can
replace a pending job in a concurrency group with a newer one, in which case
the skipped run needs a rerun. Maintainers should use the automated route for
submission PRs so the leaderboard stays in sync.

Repository maintainers are responsible for the default branch, the published
checker image, and the GitHub Actions dependencies. Report a security issue to
maintainers through the repository's private reporting feature if enabled.
