# Pattern

## What this clinic teaches
matching rows, preserving missing rows, and finding missing relationships.

## Actual tables
`users, required_checks, user_checks`.

## Actual rows that create the trap
102 missing address; 104 no checks; 103 failed identity; 105 inactive excluded.

## Why the broken query fails
It uses an INNER JOIN to existing checks, so users with no check rows disappear.

## Correct query steps
1. Read the rows at the correct grain.
2. Apply the eligibility or timing rule before comparing outputs.
3. Aggregate or rank only after the row set matches the question.
4. Use a deterministic `ORDER BY`.

## Interview phrasing
I would state the grain, name the rows that must be excluded or preserved, then explain the join, aggregate, or window function that enforces that rule.
