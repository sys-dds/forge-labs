# Pattern

## What this clinic practices
PostgreSQL DISTINCT ON for latest-row-per-entity.

## Actual tables
`listings` stores live/deleted listings and `moderation_decisions` stores reviewer decisions.

## Actual rows that trap the learner
Listing 101 has multiple decisions, listing 102 has a same-timestamp tie, listing 103 is deleted, and listing 104 has no decision.

## Why the broken query fails
The broken GROUP BY MAX timestamp duplicates listing 102 because two decisions share the same timestamp.

## Correct query shape
Use DISTINCT ON ordered by listing, decided_at descending, and decision_id descending, then left join to non-deleted listings.

## Interview wording
Name the relational rule first, then name the guardrail that keeps the answer stable across the variant seed.
