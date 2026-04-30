# Shortcut Audit

- What shortcut Codex might take: hard-code the visible answer IDs from `06-expected-output.csv` or sort with a custom `ORDER BY CASE`.
- How the proof catches it: `bip-sql-test-one.sh` greps the solution for hard-coded ID-list and literal-answer patterns, then compares exact CSV output.
- How the variant dataset catches hard-coded answers: `02b-seed-variant.sql` uses different IDs and data values while the same solution must pass `06b-expected-output-variant.csv`.
- What mutation would fail: remove the deterministic ordering or the row-preserving/filtering rule and the expected CSV diff fails.
- What the learner should inspect manually: the `posts` rows, especially 103 unsafe high score; 203 deleted high score; 101/102 tie by post_id.
