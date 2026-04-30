# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from ecosystem rules rather than returning expected output? Yes, it reads candidate rows, computes scores, filters, treatments, and traces.
3. Which function contains the clinic's core marketplace/creator logic? `rank_debuggable`.
4. Which proof would fail if the solution copied expected["final_feed"]? missing_ecosystem_explanations prove every not-shown item has a concrete stage plus rejected/downranked/debug trace assertions.
5. Which mutation from 13-mutation-checks.md would fail? Return low_score for every miss would fail no missing explanation says low_score.
