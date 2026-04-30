# Pattern

## What this clinic practices
JOIN LATERAL for top related row per parent.

## Actual tables
`buyer_intents`, `sellers`, and `listings` model buyer-specific listing matching.

## Actual rows that trap the learner
Buyer 1 has exact Glasgow plumbing choices, buyer 2 has a blocked cheapest seller, buyer 3 needs an above-budget fallback, and buyer 4 has no valid match.

## Why the broken query fails
The broken query uses one global LIMIT, so every buyer receives the same listing.

## Correct query shape
For each buyer row, use LEFT JOIN LATERAL to rank only that buyer’s valid listings by budget fit, trust, distance, and listing id.

## Interview wording
Name the relational rule first, then name the guardrail that keeps the answer stable across the variant seed.
