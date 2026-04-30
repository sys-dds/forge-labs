# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from dataset rules rather than returning expected output? Yes.
3. Which function contains the clinic’s core logic? `build_up_next_candidates`.
4. Which proof would fail if the solution copied expected["final_feed"]? Up Next, rejection, and trace assertions.
5. Which mutation from 12-mutation-checks.md would fail? Letting 501 survive fails rejection proof.
