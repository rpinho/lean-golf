You asked: Import the four pinned Lean 4 statement sets before launch and support open theorems across the checker, records, and site.
I will: Import eligible statements, validate them against the pinned Mathlib, implement the first-record and browsing flows, and report counts and test results.

## Job specification

- Work stays in this worktree and the permitted temporary root. Treat `.sources` as read-only and leave the worktree ready for the reviewer to commit.
- The three-hour window starts at 2026-11-27 21:31:25 UTC and ends at 2026-11-28 00:31:25 UTC. Allow at most six concurrent Lean processes with bounded subprocesses.
- Permitted sources are the four pinned local clones, the local Lean Golf checkout and its history, local scoreboard evidence, and the pinned Lean and Mathlib. Prior-art and novelty checks use this offline evidence.
- Deliver the importer, verified theorem folders, source licenses and notices, README counts, open-record and site changes, tests, `PRIOR_ART.md`, this checkpoint, and `REPORT.md`.
- Acceptance requires checker-generated hashes for all retained statements, working first-record and mixed-catalog flows, deterministic site output, a passing existing and new test suite, and `REPORT.md`.
- The repository checker independently verifies candidate generation. Exact compilation and hash verification cover every retained statement and require no statistical holdout.

## Frozen comparison and pass line

The baseline is the checked-out ten-seed catalog. Count named miniF2F and PutnamBench theorems, Compfiles `problem` declarations, and ProofNet textbook declarations, including entries that must be skipped because their declaration is not a theorem. An imported packet passes when the original declaration suffix survives extraction, only source-backed trusted context is added, the statement is usable under submission lint, and the pinned compiler and checker fingerprint path both accept it. Exclude solutions missing a source-backed answer and contexts that cannot be reproduced. Keep source-specific errors and audit the final catalog against the resulting receipts. Preserve the existing checker's proof validity and score rules, and give a new history event with no previous record zero characters saved.

## Import running

All four source probes now pass. The first probe run failed at the old 2 GiB Lean cap, including on `import Mathlib` before any theorem was checked. The checked-in 6 GiB Lean cap passed the four probes, including a Putnam answer restored from its source comment and a Compfiles theorem with its source abbreviation. Five import workers leave one Lean slot for the test suite. The run regenerates checkpoint receipts every 50 candidates and uses an elapsed-time stop before the three-hour job boundary.

## Batch validation checkpoint

The original fresh-process import stopped while Lake replaced the checker executable. Its session returned exit 1, and its verified packets remain in place. The prescribed `pgrep -f lean-golf-import-sources | wc -l` process count could not access macOS sysmond in this sandbox. The execution tool confirmed the original import session had exited. The replacement worker uses an immutable checker snapshot and batches equal imports, with a fresh command state and kernel replay for each packet. All four pilot hashes matched the fresh-process checker, and the restart verifies the earlier packets again before counting them.

## Recovery comparison

The first batch pass kept all 488 miniF2F statements and 662 PutnamBench statements. Recovery preserves the same raw-statement, lint, kernel replay, and hash criteria. It captures full `letI` blocks, restores statement-local includes and source-supplied options, and keeps only the scopes needed by the theorem or selected data definitions. All recovered output goes to staging first. An independent audit will compare each retained declaration with its pinned source text and check the completed receipt and file counts before promotion.

## Release verification

The four-source preliminary sweep has exited. The independent single-packet probe verified a 10-character miniF2F proof and wrote a first history event with `previous: null` in a temporary copy. The release pass validates the linted, context-injected template in a fresh module and compares its kernel type to the pinned reference type. A batch rejection is retried in a fresh compiler process. The final run uses at most five import workers plus one test worker, with an elapsed-time limit of 55 minutes for the import.

The final verifier distinguishes Lean's generated partial executable implementations from its safe recursive kernel definitions. The contextual first-record test passed with that correction. The targeted recheck will include every receipt with the generated-declaration rejection, regardless of source or prospective outcome.

The targeted recheck also includes Compfiles IMO 2025 P4. Its source has the only `public meta import` in the four scanned sets. The statement extractor now recognizes that proof-only import form separately from statement imports. The same raw-type and checker gates apply.

## Complete

The final catalog contains 2,020 verified open packets and the ten tracked seeds. The targeted recheck recovered 22 packets. The separate provenance audit matched every retained raw declaration suffix, checker hash, license, and source label against the staged data and pinned clones. The full 80-test suite passed. Two full site builds produced 2,232 byte-identical files and 11,366 valid internal links. The importer, recheck, spot-check, site, and test sessions exited. The final harvest preserved the earlier work in staging.
