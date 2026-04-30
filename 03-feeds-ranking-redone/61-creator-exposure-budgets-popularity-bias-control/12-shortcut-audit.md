# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from ecosystem rules rather than returning expected output? Yes, it reads candidate rows, computes scores, filters, treatments, and traces.
3. Which function contains the clinic's core marketplace/creator logic? `rank_with_exposure_budget`.
4. Which proof would fail if the solution copied expected["final_feed"]? exact exposure_rows and final_feed include Maya and Lina while rejecting Noor plus rejected/downranked/debug trace assertions.
5. Which mutation from 13-mutation-checks.md would fail? Remove repeated Ben cap would fail repeated overexposed Ben post must be downranked.
