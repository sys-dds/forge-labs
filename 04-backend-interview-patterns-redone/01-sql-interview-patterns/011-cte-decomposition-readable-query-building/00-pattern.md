# Pattern

## What this clinic teaches
Readable CTE decomposition for a multi-rule seller eligibility query.

## Actual tables
`sellers, listings, orders, listing_impressions`.

## Actual rows that create the trap
seller 102 has enough listings but weak fulfilment; seller 103 has good fulfilment but no recent impressions; seller 104 has recent impressions but too few completed orders; seller 105 is inactive; seller 101 is eligible.

## Why the broken query fails
It joins recent impressions too early and counts orders after row multiplication, so thresholds can be crossed by duplicated evidence.

## Correct query steps
1. Establish the row grain before filtering or ranking.
2. Keep disqualifying or missing evidence visible long enough to score it.
3. Compute the metric from data values rather than final IDs.
4. Return columns in the expected order with deterministic ordering.

## Interview phrasing
Say which table provides the entity, which table provides the evidence, which rows are traps, and why the SQL shape proves the business rule.
