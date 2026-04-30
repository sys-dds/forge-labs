# Pattern

## What this clinic teaches
cohort date plus exact day-1 and day-7 retention windows.

## Actual tables
`creators, creator_activity`.

## Actual rows that create the trap
102 active day 6 but not day 7; 104 day 7 retained; 101 day 1 and day 7 retained.

## Why the broken query fails
It counts any future activity as both day-1 and day-7 retained.

## Correct query steps
1. Read the rows at the correct grain.
2. Apply the eligibility or timing rule before comparing outputs.
3. Aggregate or rank only after the row set matches the question.
4. Use a deterministic `ORDER BY`.

## Interview phrasing
I would state the grain, name the rows that must be excluded or preserved, then explain the join, aggregate, or window function that enforces that rule.
