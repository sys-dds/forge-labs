# Pattern

## What this clinic teaches
latest row per entity with ROW_NUMBER over partitions.

## Actual tables
`listing_status_events`.

## Actual rows that create the trap
102 latest sold; 103 duplicate timestamp tie by event_id removed; 105 older sold then latest available.

## Why the broken query fails
It aggregates status and timestamp separately, creating statuses that do not necessarily belong to the latest event row.

## Correct query steps
1. Read the rows at the correct grain.
2. Apply the eligibility or timing rule before comparing outputs.
3. Aggregate or rank only after the row set matches the question.
4. Use a deterministic `ORDER BY`.

## Interview phrasing
I would state the grain, name the rows that must be excluded or preserved, then explain the join, aggregate, or window function that enforces that rule.
