# Shortcut Audit

- Likely shortcut: hard-code final IDs from `06-expected-output.csv`, force sort order with ID-specific `ORDER BY CASE`, or create expected-answer rows in SQL.
- How base proof catches it: the base CSV diff checks exact columns, order, and values for `price_events`.
- How variant proof catches it: the variant dataset catches hard-coded answers because IDs and threshold outcomes change while the same solution SQL must pass.
- What mutation should fail: Compare against MAX(price_pence) and listing 103 or later events can be misclassified..
- What the learner should inspect manually: listing 101 has a later large drop after a small drop; listing 102 increases; listing 103 has only a small drop; listing 104 has one price event; listing 105 has same-timestamp events that require event_id tie-break.
