# Pattern

## What this clinic teaches
Comparing each row with its immediately previous related row.

## Actual tables
`price_events`.

## Actual rows that create the trap
listing 101 has a later large drop after a small drop; listing 102 increases; listing 103 has only a small drop; listing 104 has one price event; listing 105 has same-timestamp events that require event_id tie-break.

## Why the broken query fails
It compares each price to the maximum historical price, not the immediately previous price event.

## Correct query steps
1. Establish the row grain before filtering or ranking.
2. Keep disqualifying or missing evidence visible long enough to score it.
3. Compute the metric from data values rather than final IDs.
4. Return columns in the expected order with deterministic ordering.

## Interview phrasing
Say which table provides the entity, which table provides the evidence, which rows are traps, and why the SQL shape proves the business rule.
