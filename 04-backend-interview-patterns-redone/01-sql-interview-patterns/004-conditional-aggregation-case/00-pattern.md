# Pattern

## What this clinic teaches
SUM(CASE WHEN ...) and multiple metrics in one grouped query.

## Actual tables
`sellers, orders`.

## Actual rows that create the trap
103 has zero completed orders; 102 has dispute and refund; pending rows stay in denominator.

## Why the broken query fails
It filters to completed orders before aggregating, so cancellation, dispute, pending, and zero-completed sellers disappear.

## Correct query steps
1. Read the rows at the correct grain.
2. Apply the eligibility or timing rule before comparing outputs.
3. Aggregate or rank only after the row set matches the question.
4. Use a deterministic `ORDER BY`.

## Interview phrasing
I would state the grain, name the rows that must be excluded or preserved, then explain the join, aggregate, or window function that enforces that rule.
