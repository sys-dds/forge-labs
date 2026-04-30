# Shortcut Audit

- Likely shortcut: hard-code final IDs from `06-expected-output.csv`, force sort order with ID-specific `ORDER BY CASE`, or create expected-answer rows in SQL.
- How base proof catches it: the base CSV diff checks exact columns, order, and values for `sellers, listings, orders, listing_impressions`.
- How variant proof catches it: the variant dataset catches hard-coded answers because IDs and threshold outcomes change while the same solution SQL must pass.
- What mutation should fail: Remove the recent impression CTE and seller 103 would incorrectly look eligible..
- What the learner should inspect manually: seller 102 has enough listings but weak fulfilment; seller 103 has good fulfilment but no recent impressions; seller 104 has recent impressions but too few completed orders; seller 105 is inactive; seller 101 is eligible.
