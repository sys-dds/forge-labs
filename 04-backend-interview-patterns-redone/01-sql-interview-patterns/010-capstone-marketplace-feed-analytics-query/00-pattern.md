# Pattern

## What this clinic teaches
joins, filtering, aggregation, conditional metrics, windows, and seller treatment.

## Actual tables
`sellers, listings, orders, listing_events`.

## Actual rows that create the trap
101 high quality boost; 102 popular risky suppress; 103 cold-start allow; 104 high impressions poor booking watch; 105 blocked listing excluded; 106 no recent impressions.

## Why the broken query fails
It ranks by impressions only and ignores fulfilment, response, blocked listings, and conversion rates.

## Correct query steps
1. Read the rows at the correct grain.
2. Apply the eligibility or timing rule before comparing outputs.
3. Aggregate or rank only after the row set matches the question.
4. Use a deterministic `ORDER BY`.

## Interview phrasing
I would state the grain, name the rows that must be excluded or preserved, then explain the join, aggregate, or window function that enforces that rule.
