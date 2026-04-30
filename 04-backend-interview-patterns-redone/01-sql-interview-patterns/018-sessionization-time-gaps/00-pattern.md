# Pattern

## What this clinic teaches
Using LAG and cumulative sums to form sessions after inactivity gaps.

## Actual tables
`feed_events`.

## Actual rows that create the trap
user 101 has exactly a 30-minute gap that stays in session; user 101 has a 31-minute gap that starts a new session; duplicate timestamps require event_id tie-break; multiple users appear.

## Why the broken query fails
It groups every event per user into one session and misses inactivity boundaries.

## Correct query steps
1. Establish the row grain before filtering or ranking.
2. Keep disqualifying or missing evidence visible long enough to score it.
3. Compute the metric from data values rather than final IDs.
4. Return columns in the expected order with deterministic ordering.

## Interview phrasing
Say which table provides the entity, which table provides the evidence, which rows are traps, and why the SQL shape proves the business rule.
