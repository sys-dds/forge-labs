# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from ecosystem rules rather than returning expected output? Yes, it reads candidate rows, computes scores, filters, treatments, and traces.
3. Which function contains the clinic's core marketplace/creator logic? `build_ecosystem_system_design`.
4. Which proof would fail if the solution copied expected["final_feed"]? capstone proof checks final feed rejected risk missing rows rich design and handoff contract plus rejected/downranked/debug trace assertions.
5. Which mutation from 13-mutation-checks.md would fail? Return boolean design would fail creator_exposure_policy must be rich nested object.
