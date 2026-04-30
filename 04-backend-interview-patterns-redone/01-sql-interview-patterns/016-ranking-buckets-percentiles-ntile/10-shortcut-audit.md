# Shortcut Audit

- Likely shortcut: hard-code final IDs from `06-expected-output.csv`, force sort order with ID-specific `ORDER BY CASE`, or create expected-answer rows in SQL.
- How base proof catches it: the base CSV diff checks exact columns, order, and values for `creators`.
- How variant proof catches it: the variant dataset catches hard-coded answers because IDs and threshold outcomes change while the same solution SQL must pass.
- What mutation should fail: Remove report penalties and creator 102 moves to the wrong bucket..
- What the learner should inspect manually: creator 102 has high engagement but many reports; creator 103 has low engagement but high trust; creators 101 and 104 tie; eight creators fill all four buckets.
