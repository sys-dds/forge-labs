# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from dataset rules rather than returning expected output? Yes.
3. Which function contains the clinic's core logic? The named rank or choose function in `03-solution.py`.
4. Which proof would fail if the solution copied expected["final_feed"]? The proof also checks rejected items, traces, sources/features/scores, and surface-specific outputs.
5. Which mutation from 12-mutation-checks.md would fail? The first listed mutation would fail the exact output or rejection proof.
