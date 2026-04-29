# Window Functions and Ranking Basics

## Plain-English Concept

Window functions add per-row context without collapsing rows the way GROUP BY does.

## Real-World Backend Pattern

Ranking systems need ordered candidate rows and raw signals such as latest post, engagement rank, and running totals.

## Mental Model

Think in three layers: the fact stored in a row, the rule that keeps the fact safe, and the query that turns safe facts into a backend response or candidate set.

## Step-By-Step Example

1. ROW_NUMBER selects one latest row per author.
2. RANK gives tied posts the same rank and leaves gaps.
3. DENSE_RANK gives tied authors the same rank without gaps.
4. Running totals accumulate metrics within each author partition.
5. Feed ranking inputs expose columns, not final recommendations.

## Common Interview Phrasing

"I would model the durable facts first, put invariants in the database where races cannot bypass them, then shape the query so the application receives only the rows and columns it is allowed to use."

## What Can Go Wrong

- ROW_NUMBER without deterministic tie-breaker
- confusing RANK and DENSE_RANK
- running total without partition
- treating ranking input columns as a ranking algorithm

## Next Unlock

Ranking-shaped SQL output prepares the later ranking/matching path without implementing a scoring algorithm yet.
