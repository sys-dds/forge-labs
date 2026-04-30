# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from ecosystem rules rather than returning expected output? Yes, it reads candidate rows, computes scores, filters, treatments, and traces.
3. Which function contains the clinic's core marketplace/creator logic? `rank_by_supply_demand_balance`.
4. Which proof would fail if the solution copied expected["final_feed"]? supply_rows and demand_rows prove nearby backfill appears when Glasgow has high demand and low supply plus rejected/downranked/debug trace assertions.
5. Which mutation from 13-mutation-checks.md would fail? Remove nearby backfill would fail exact supply demand rankings.
