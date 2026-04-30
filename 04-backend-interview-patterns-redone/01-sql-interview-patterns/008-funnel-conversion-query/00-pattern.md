# Pattern

## What this clinic teaches
ordered funnel steps with timestamp conditions.

## Actual tables
`funnel_events`.

## Actual rows that create the trap
103 contacts before view; 102 skips contacted; 104 repeats contacted; 105 reaches booking only.

## Why the broken query fails
It counts each event type independently, so out-of-order and skipped steps inflate later funnel stages.

## Correct query steps
1. Read the rows at the correct grain.
2. Apply the eligibility or timing rule before comparing outputs.
3. Aggregate or rank only after the row set matches the question.
4. Use a deterministic `ORDER BY`.

## Interview phrasing
I would state the grain, name the rows that must be excluded or preserved, then explain the join, aggregate, or window function that enforces that rule.

The `funnel_steps` table provides the interview step labels and their deterministic order, so the query does not manufacture final rows from string literals.
