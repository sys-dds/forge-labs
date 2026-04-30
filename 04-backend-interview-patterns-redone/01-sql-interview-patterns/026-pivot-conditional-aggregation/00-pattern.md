# Pattern

## What this clinic practices
conditional aggregation to pivot event rows into metric columns.

## Actual tables
`sellers` and `orders` produce a weekly seller operations row per seller.

## Actual rows that trap the learner
Ben has all statuses, Diya has zero orders, Omar has only cancelled orders, Maya has a refunded order, and a test order must be excluded.

## Why the broken query fails
The broken query filters completed orders before aggregation, losing cancellations, disputes, refunds, and zero-order sellers.

## Correct query shape
LEFT JOIN weekly non-test orders and use COUNT/SUM FILTER expressions for each metric column.

## Interview wording
Name the relational rule first, then name the guardrail that keeps the answer stable across the variant seed.
