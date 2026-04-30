# Shortcut Audit

- Likely shortcut: hard-code final IDs from `06-expected-output.csv`, force sort order with ID-specific `ORDER BY CASE`, or create expected-answer rows in SQL.
- How base proof catches it: the base CSV diff checks exact columns, order, and values for `seller_events, trust_policies`.
- How variant proof catches it: the variant dataset catches hard-coded answers because IDs and threshold outcomes change while the same solution SQL must pass.
- What mutation should fail: Use <= effective_to and a boundary event can match the old policy..
- What the learner should inspect manually: event before first policy gets no_active_policy; event exactly on boundary uses the new policy; draft overlapping policy must be ignored; open-ended current policy remains active.
