# Shortcut Audit

- Likely shortcut: hard-code the final IDs or static output order from the base seed.
- How base proof catches it: the base CSV checks exact columns, values, and order.
- How variant dataset catches hard-coded answers: the variant dataset catches a static answer because at least one eligible row, metric, or treatment changes.
- What mutation should fail: changing the trap row described in the pattern should change the output or the proof should fail.
- What the learner should inspect manually: inspect `05-solution.sql` for relational predicates, deterministic ordering, and absence of expected-answer tables.
