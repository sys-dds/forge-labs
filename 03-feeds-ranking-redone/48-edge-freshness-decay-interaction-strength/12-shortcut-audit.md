# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from graph rules rather than returning expected output? Yes, the solution runs the clinic's graph functions over `01-dataset.json`.
3. Which function contains the clinic’s core graph logic? See the solution function named for edge decay and interaction strength.
4. Which proof would fail if the solution copied expected["graph_candidates"]? The trace and semantic row assertions would fail.
5. Which mutation from 13-mutation-checks.md would fail? Returning expected graph candidates directly would fail the debug trace/source row proof.
