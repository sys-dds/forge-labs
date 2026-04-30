# Shortcut Audit

- Likely shortcut: hard-code final IDs from `06-expected-output.csv`, force sort order with ID-specific `ORDER BY CASE`, or create expected-answer rows in SQL.
- How base proof catches it: the base CSV diff checks exact columns, order, and values for `buyers, payment_methods, identity_checks, fraud_cases, chargebacks`.
- How variant proof catches it: the variant dataset catches hard-coded answers because IDs and threshold outcomes change while the same solution SQL must pass.
- What mutation should fail: Remove the recent chargeback anti-join and buyer 105 would incorrectly pass..
- What the learner should inspect manually: buyer 102 has no verified payment method; buyer 103 failed identity verification; buyer 104 has an old chargeback outside the window; buyer 105 has a recent chargeback; buyer 106 has an open fraud case.
