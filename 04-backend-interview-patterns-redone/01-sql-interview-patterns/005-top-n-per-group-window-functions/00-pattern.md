# Pattern

## What this clinic teaches
ROW_NUMBER with PARTITION BY for top-N per group.

## Actual tables
`posts`.

## Actual rows that create the trap
103 unsafe high score; 203 deleted high score; 101/102 tie by post_id.

## Why the broken query fails
It applies a global LIMIT 2, returning only the two highest posts overall instead of two per topic.

## Correct query steps
1. Read the rows at the correct grain.
2. Apply the eligibility or timing rule before comparing outputs.
3. Aggregate or rank only after the row set matches the question.
4. Use a deterministic `ORDER BY`.

## Interview phrasing
I would state the grain, name the rows that must be excluded or preserved, then explain the join, aggregate, or window function that enforces that rule.
