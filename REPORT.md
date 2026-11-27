Shipped: 2,020 verified open theorems and first-record support for a 2,030-theorem Lean Golf catalog.

## Coverage

| Source | Candidates | Kept open | Skipped | Reference elaboration failed | Later checks failed |
| --- | ---: | ---: | ---: | ---: | ---: |
| miniF2F | 488 | 488 | 0 | 0 | 0 |
| PutnamBench | 672 | 672 | 0 | 0 | 0 |
| Compfiles | 554 | 534 | 0 | 19 | 1 |
| ProofNet | 374 | 326 | 14 | 34 | 0 |

- **miniF2F** — Skips 0. Verification failures 0.
- **PutnamBench** — Skips 0. Verification failures 0.
- **Compfiles** — Skips 0. Verification failures 19 unresolved identifier or field, 1 other.
- **ProofNet** — Skips 14 not a theorem declaration. Verification failures 27 ambiguous or overloaded term, 4 type or instance mismatch, 3 unresolved identifier or field.

The 14 ProofNet skips are exercises declared as instances with data types such as group isomorphisms and ring structures. Lean Golf accepts theorems of type `Prop`. The extractor also tests missing-answer exclusion with a synthetic fixture. The trusted statement context includes 346 PutnamBench answers supplied in source comments and source-backed Compfiles data definitions. For 93 Compfiles packets with moved Mathlib imports, the packet uses the pinned Mathlib umbrella and retains the original list as `source_imports`. Duplicate Compfiles declaration names use the source filename to distinguish their packets.

## Verification

Verified pinned provenance, exact raw declaration suffixes, licenses, file pairs, and checker hashes. The checker compiled a separate, linted submission template for each kept theorem and compared its kernel type with the reference. It then replayed the trusted declarations and computed the canonical SHA-256 statement hash. This is an exact check across the full eligible set, so a statistical holdout does not apply.

The first-record smoke test used a real miniF2F packet. The checker accepted its 10-character proof and `records.py` wrote a first event with `previous: null` in a temporary copy. Tests also exercise the trusted merge receipt, strict score improvements, source filters, pagination, and deterministic SVG output.

Two full site builds produced 2,232 byte-identical files, 11,366 valid local links, and 10 record cards. The build contains 188 catalog pages and 2,030 theorem pages. The index is 4,110 bytes. The index lists all ten seeds first, shows open and recorded totals, and links source catalogs with 50 rows per page. PutnamBench filters include both year and A/B position.

## Failed attempts and remaining limits

- The first compiler probes exceeded the former 2 GiB Lean cap on Mathlib. The validated cap is 6 GiB, with one compiler thread, a 120-second checker deadline, and a 10 GiB container budget. The first long sweep also hit an executable replacement during a Lake rebuild. The importer now takes an immutable executable snapshot.
- Lean emits partially compiled executable definitions for some safe recursive functions. The first release pass rejected those helpers. The final checker excludes the trusted reference's matching runtime definitions from replay and checks the safe definitions. The targeted run retried every generated-declaration rejection and the one proof-only `meta import` parsing case and recovered 22 packets.
- The worktree checks ran offline on macOS. The local Docker socket was unavailable. A reviewer can run the packaged Linux checker before deployment and review the remaining source failures. PutnamBench documents its proof-sharing request in its upstream README. [Prior art and upstream guidance](PRIOR_ART.md)
- The four pinned source credits, license texts, and extraction notices are in the packets and [NOTICES.md](NOTICES.md).

## Reproduce

```sh
export PATH="$HOME/.elan/bin:$PATH"
lake -q build golfcheck
python3 scripts/import_sources.py --jobs 5 --seconds 3300 --receipts .lake/import-receipts.json
lake -q exe golfcheck --statement theorems/minif2f-mathd_numbertheory_101
python3 site/build.py --out .lake/site-check
pytest_dir=$(mktemp -d "$PWD/.lake/pytest-check.XXXXXX")
set -o pipefail
"${PYTEST_PYTHON:-python3}" -m pytest -q --basetemp "$pytest_dir" 2>&1 | tail -n 3
test -f REPORT.md
```

A fresh-process recheck matched the hashes of one packet from each source. The full suite ran with the requested virtual environment's Python. Test output tail follows.

```text
........................................................................ [ 90%]
........                                                                 [100%]
80 passed in 285.58s (0:04:45)
```

## Review verdict

- **CONTROLS:** No. `lake exe golfcheck --statement` uses the same canonical type comparison as proof checking. The release audit matched all 2,020 staged statement hashes to checker receipts, and all ten seed checks passed in the 80-test suite.
- **CONTRADICTING:** No. The 2,088 candidate receipts include 14 skips and 54 final failures. For example, Compfiles `imo1992_p5` remains excluded after its reference and submission template produced different kernel types. All rejected rows are included in the table.
- **LABELS:** No. The separate audit compared raw source declaration suffixes, difficulty labels, and license bytes with the pinned clones, and verified the actual file pairs for all 2,020 open packets. The generated index showed 2,020 open and 10 recorded. The site audit found ten SVG cards.
