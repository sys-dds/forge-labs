# Pattern

## What this clinic practices
FULL OUTER JOIN reconciliation between systems.

## Actual tables
`orders` is the marketplace source of truth and `ledger_entries` is the financial posting system.

## Actual rows that trap the learner
Order 1002 has no ledger, ledger 9003 has no order, order 1004 has an amount mismatch, order 1005 has a refund posting mismatch, and cancelled order 1006 needs no ledger.

## Why the broken query fails
The broken INNER JOIN can only see rows that exist in both systems, so missing ledger and extra ledger disappear.

## Correct query shape
FULL OUTER JOIN by order id, keep rows with missing sides, amount differences, or status/posting-type disagreements.

## Interview wording
Name the relational rule first, then name the guardrail that keeps the answer stable across the variant seed.
