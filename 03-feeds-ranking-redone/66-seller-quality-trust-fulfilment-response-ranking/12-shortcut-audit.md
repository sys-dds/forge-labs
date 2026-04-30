# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from ecosystem rules rather than returning expected output? Yes, it reads candidate rows, computes scores, filters, treatments, and traces.
3. Which function contains the clinic's core marketplace/creator logic? `rank_by_seller_quality`.
4. Which proof would fail if the solution copied expected["final_feed"]? seller_quality_rows prove response cancellation dispute and fulfilment quality change ranking plus rejected/downranked/debug trace assertions.
5. Which mutation from 13-mutation-checks.md would fail? Rank by rating would fail exact seller quality rankings.
