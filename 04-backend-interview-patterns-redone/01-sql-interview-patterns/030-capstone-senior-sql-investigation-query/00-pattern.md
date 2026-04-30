# Pattern

## What this clinic practices
senior investigation query combining metrics, latest rows, reconciliation, transition debugging, and ratio safety.

## Actual tables
`sellers`, `listings`, `orders`, `disputes`, `refunds`, `response_events`, `listing_events`, `moderation_decisions`, `ledger_entries`, `order_status_events`, and `fraud_cases` form the incident dataset.

## Actual rows that trap the learner
Ben should boost, Omar has fraud, Diya has high impressions with low booking, Maya has a ledger mismatch, Lina has invalid transitions, Noor has no recent impressions, Cy has blocked listings only, and Theo is cold-start.

## Why the broken query fails
The broken query ranks by impressions and ignores fraud, reconciliation, moderation, and state transitions.

## Correct query shape
Build seller metric CTEs, latest moderation with DISTINCT ON, FULL OUTER reconciliation counts, LAG transition counts, safe rates, and a treatment CASE.

## Interview wording
Name the relational rule first, then name the guardrail that keeps the answer stable across the variant seed.
