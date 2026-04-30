# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from dataset rules rather than returning expected output? Yes.
3. Which function contains the clinic's core retrieval logic? `merge_popular_and_cold_start`.
4. Which proof would fail if the solution copied expected["retrieved_candidates"]? The source-label, missed-candidate, rejected-row, policy, report, and retrieval trace assertions would fail.
5. Which mutation from 13-mutation-checks.md would fail? `Remove cold-start backfill`.
