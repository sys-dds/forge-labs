# Pattern

## What this clinic teaches
WHERE filters, deterministic ORDER BY, LIMIT, and NULL price behavior.

## Actual tables
`listings`.

## Actual rows that create the trap
103 NULL price; 104 sold; 105 blocked; 106 and 108 tie by price and listing_id.

## Why the broken query fails
It orders by price before filtering eligibility, so NULL, sold, or blocked rows can leak into the top results.

## Correct query steps
1. Read the rows at the correct grain.
2. Apply the eligibility or timing rule before comparing outputs.
3. Aggregate or rank only after the row set matches the question.
4. Use a deterministic `ORDER BY`.

## Interview phrasing
I would state the grain, name the rows that must be excluded or preserved, then explain the join, aggregate, or window function that enforces that rule.
