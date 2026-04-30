# Pattern

## What this clinic teaches
EXISTS for required evidence and NOT EXISTS for disqualifying evidence.

## Actual tables
`buyers, payment_methods, identity_checks, fraud_cases, chargebacks`.

## Actual rows that create the trap
buyer 102 has no verified payment method; buyer 103 failed identity verification; buyer 104 has an old chargeback outside the window; buyer 105 has a recent chargeback; buyer 106 has an open fraud case.

## Why the broken query fails
It inner joins payment methods and identity checks, so duplicates can appear and NOT EXISTS disqualifiers are not applied at the buyer grain.

## Correct query steps
1. Establish the row grain before filtering or ranking.
2. Keep disqualifying or missing evidence visible long enough to score it.
3. Compute the metric from data values rather than final IDs.
4. Return columns in the expected order with deterministic ordering.

## Interview phrasing
Say which table provides the entity, which table provides the evidence, which rows are traps, and why the SQL shape proves the business rule.
