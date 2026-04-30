# Explain In Interview

## Direct answer
Use `buyers, payment_methods, identity_checks, fraud_cases, chargebacks` to answer: Find active buyers allowed to book high-value services: verified payment method exists, identity verification passed, no open fraud case, and no chargeback since 2026-01-01.

## Dataset walkthrough
The base dataset includes buyer 102 has no verified payment method; buyer 103 failed identity verification; buyer 104 has an old chargeback outside the window; buyer 105 has a recent chargeback; buyer 106 has an open fraud case. Those rows exist so a shortcut or known-dataset query gives the wrong answer.

## Query reasoning
The solution starts from active buyers and uses EXISTS for required positive evidence, then NOT EXISTS for open fraud and recent chargebacks.

## Common mistake
It inner joins payment methods and identity checks, so duplicates can appear and NOT EXISTS disqualifiers are not applied at the buyer grain.

## Senior trade-off
Prefer visible CTEs, row-grain comments in your explanation, and deterministic ordering over a compact query that hides why rows survived.

## Follow-up answer
Ask for a denial reason per buyer by replacing filters with CASE expressions.
