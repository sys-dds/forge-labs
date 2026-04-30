# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from ecosystem rules rather than returning expected output? Yes, it reads candidate rows, computes scores, filters, treatments, and traces.
3. Which function contains the clinic's core marketplace/creator logic? `rank_after_risk_suppression`.
4. Which proof would fail if the solution copied expected["final_feed"]? risk_score_rows prove cheap listings can be suppressed by fraud dispute and refund evidence plus rejected/downranked/debug trace assertions.
5. Which mutation from 13-mutation-checks.md would fail? Rank by price would fail exact risk-suppressed rankings.
