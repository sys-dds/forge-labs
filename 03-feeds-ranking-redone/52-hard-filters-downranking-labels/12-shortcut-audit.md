# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from policy/trust rules rather than returning expected output? Yes.
3. Which function contains the clinic’s core safety/integrity logic? The solution function that maps hard filters vs downranking vs labels evidence into treatment rows.
4. Which proof would fail if the solution copied expected["safe_feed"]? The semantic treatment/evidence/trace assertions would fail.
5. Which mutation from 13-mutation-checks.md would fail? Returning expected safe_feed directly would fail the trace and semantic row proof.
