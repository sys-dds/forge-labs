# Pattern

## What this clinic teaches
Generating date rows so missing days appear as zeroes.

## Actual tables
`bookings`.

## Actual rows that create the trap
2026-01-02 has only a cancelled booking; 2026-01-03 has no rows; 2026-01-08 is outside the range; 2026-01-01 has multiple completed bookings.

## Why the broken query fails
It groups bookings directly, so dates with no completed bookings vanish from the report.

## Correct query steps
1. Establish the row grain before filtering or ranking.
2. Keep disqualifying or missing evidence visible long enough to score it.
3. Compute the metric from data values rather than final IDs.
4. Return columns in the expected order with deterministic ordering.

## Interview phrasing
Say which table provides the entity, which table provides the evidence, which rows are traps, and why the SQL shape proves the business rule.
