# Shortcut Audit

- Likely shortcut: hard-code final IDs from `06-expected-output.csv`, force sort order with ID-specific `ORDER BY CASE`, or create expected-answer rows in SQL.
- How base proof catches it: the base CSV diff checks exact columns, order, and values for `sellers, listings, orders, disputes, refunds, response_events, listing_impressions, fraud_cases`.
- How variant proof catches it: the variant dataset catches hard-coded answers because IDs and threshold outcomes change while the same solution SQL must pass.
- What mutation should fail: Remove the open fraud EXISTS CTE and seller 104 would not be suppressed..
- What the learner should inspect manually: seller 101 is strong; seller 102 is popular but dispute/refund risky; seller 103 is cold-start; seller 104 has open fraud; seller 105 has high impressions and poor bookings; seller 106 has blocked listings only; seller 107 has no recent impressions.
