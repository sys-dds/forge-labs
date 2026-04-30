# Pattern

## What this clinic teaches
Combining CTEs, EXISTS, joins, conditional aggregation, windows, date logic, and treatment decisions.

## Actual tables
`sellers, listings, orders, disputes, refunds, response_events, listing_impressions, fraud_cases`.

## Actual rows that create the trap
seller 101 is strong; seller 102 is popular but dispute/refund risky; seller 103 is cold-start; seller 104 has open fraud; seller 105 has high impressions and poor bookings; seller 106 has blocked listings only; seller 107 has no recent impressions.

## Why the broken query fails
It ranks by impressions only and misses fraud, dispute, refund, response, conversion, blocked-listing, and cancellation evidence.

## Correct query steps
1. Establish the row grain before filtering or ranking.
2. Keep disqualifying or missing evidence visible long enough to score it.
3. Compute the metric from data values rather than final IDs.
4. Return columns in the expected order with deterministic ordering.

## Interview phrasing
Say which table provides the entity, which table provides the evidence, which rows are traps, and why the SQL shape proves the business rule.
