# EXISTS and NOT EXISTS semi/anti join patterns

Scenario: Buyer trust checks before high-value booking.

The query works over `buyers, payment_methods, identity_checks, fraud_cases, chargebacks`. The trap rows are buyer 102 has no verified payment method; buyer 103 failed identity verification; buyer 104 has an old chargeback outside the window; buyer 105 has a recent chargeback; buyer 106 has an open fraud case. The base and variant seeds use different IDs and values, so the solution has to derive the answer from relational rules.
