# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from dataset rules rather than returning expected output? Yes.
3. Which function contains the clinic's core retrieval logic? `retrieve_top_k_for_user`.
4. Which proof would fail if the solution copied expected["retrieved_candidates"]? The proof checking score/probe rows, source labels, missed candidates, rejected rows, and retrieval trace would fail.
5. Which mutation from 13-mutation-checks.md would fail? `Use same pool for all users`.
