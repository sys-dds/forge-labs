# Pattern

## What this clinic teaches
Rolling 3-row moving averages over ordered listing-day rows.

## Actual tables
`daily_listing_impressions`.

## Actual rows that create the trap
listing 101 has a zero-impression day; listing 101 skips a calendar day; listing 102 has a full 3-day window; multiple listings are partitioned separately.

## Why the broken query fails
It uses one AVG over all rows for the listing instead of a rolling three-row frame.

## Correct query steps
1. Establish the row grain before filtering or ranking.
2. Keep disqualifying or missing evidence visible long enough to score it.
3. Compute the metric from data values rather than final IDs.
4. Return columns in the expected order with deterministic ordering.

## Interview phrasing
Say which table provides the entity, which table provides the evidence, which rows are traps, and why the SQL shape proves the business rule.
