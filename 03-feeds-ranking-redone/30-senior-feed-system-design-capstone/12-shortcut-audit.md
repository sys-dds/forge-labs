# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from dataset rules rather than returning expected output? Yes.
3. Which function contains the clinic's core logic? `build_system_design_object`.
4. Which proof would fail if the solution copied expected["final_feed"]? The surface, rejection, guardrail, replay, and design-layer assertions would fail.
5. Which mutation from 13-mutation-checks.md would fail? Remove shared safety layer.
