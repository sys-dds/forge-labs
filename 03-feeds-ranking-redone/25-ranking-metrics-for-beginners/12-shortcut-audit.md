# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from dataset rules rather than returning expected output? Yes.
3. Which function contains the clinic's core logic? `choose_variant_with_guardrails`.
4. Which proof would fail if the solution copied expected["final_feed"]? The trace, rejection, metric, or guardrail assertion would fail.
5. Which mutation from 13-mutation-checks.md would fail? `Choose highest CTR`.
