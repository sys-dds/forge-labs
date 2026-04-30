# Shortcut Audit

- Likely shortcut: hard-code final IDs from `06-expected-output.csv`, force sort order with ID-specific `ORDER BY CASE`, or create expected-answer rows in SQL.
- How base proof catches it: the base CSV diff checks exact columns, order, and values for `daily_listing_impressions`.
- How variant proof catches it: the variant dataset catches hard-coded answers because IDs and threshold outcomes change while the same solution SQL must pass.
- What mutation should fail: Change ROWS BETWEEN 2 PRECEDING to UNBOUNDED PRECEDING and later moving averages change..
- What the learner should inspect manually: listing 101 has a zero-impression day; listing 101 skips a calendar day; listing 102 has a full 3-day window; multiple listings are partitioned separately.
