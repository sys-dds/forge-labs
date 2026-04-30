# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from dataset rules rather than returning expected output? Yes.
3. Which function contains the clinic's core logic? `make_launch_decision`.
4. Which proof would fail if the solution copied expected["final_feed"]? The guardrail, trace, rejection, or surface assertion would fail.
5. Which mutation from 13-mutation-checks.md would fail? `Launch on CTR alone`.
