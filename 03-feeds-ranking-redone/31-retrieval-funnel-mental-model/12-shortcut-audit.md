# Shortcut Audit

1. Did this clinic use clinic.startswith dispatching? No.
2. Did the solution derive output from dataset rules rather than returning expected output? Yes.
3. Which function contains the clinic's core retrieval logic? `build_final_candidate_pool`.
4. Which proof would fail if the solution copied expected["retrieved_candidates"]? The proof that checks source labels, missed candidates, rejected rows, similarity or metric evidence, and retrieval debug traces.
5. Which mutation from 13-mutation-checks.md would fail? `Remove cold-start exploration 901`.
