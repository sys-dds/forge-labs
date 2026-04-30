# Pattern

## What this clinic teaches
Computed scores, ranking, and quartile-style buckets.

## Actual tables
`creators`.

## Actual rows that create the trap
creator 102 has high engagement but many reports; creator 103 has low engagement but high trust; creators 101 and 104 tie; eight creators fill all four buckets.

## Why the broken query fails
It buckets by follower count instead of the trust-adjusted engagement score.

## Correct query steps
1. Establish the row grain before filtering or ranking.
2. Keep disqualifying or missing evidence visible long enough to score it.
3. Compute the metric from data values rather than final IDs.
4. Return columns in the expected order with deterministic ordering.

## Interview phrasing
Say which table provides the entity, which table provides the evidence, which rows are traps, and why the SQL shape proves the business rule.
