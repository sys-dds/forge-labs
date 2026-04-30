# Pattern

## What this clinic teaches
Joining facts to the policy record active at event time.

## Actual tables
`seller_events, trust_policies`.

## Actual rows that create the trap
event before first policy gets no_active_policy; event exactly on boundary uses the new policy; draft overlapping policy must be ignored; open-ended current policy remains active.

## Why the broken query fails
It joins every event to the latest policy globally and ignores historical effective dates.

## Correct query steps
1. Establish the row grain before filtering or ranking.
2. Keep disqualifying or missing evidence visible long enough to score it.
3. Compute the metric from data values rather than final IDs.
4. Return columns in the expected order with deterministic ordering.

## Interview phrasing
Say which table provides the entity, which table provides the evidence, which rows are traps, and why the SQL shape proves the business rule.
