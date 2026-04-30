# Pattern

## What this clinic teaches
GROUP BY, HAVING, COUNT(*), COUNT(column), and conditional counts.

## Actual tables
`creators, posts`.

## Actual rows that create the trap
102 has NULL and low engagement; 104 has draft/deleted rows; 101 has one zero engagement row.

## Why the broken query fails
It counts every joined row, including draft and deleted posts, and treats total rows as meaningful engagement.

## Correct query steps
1. Read the rows at the correct grain.
2. Apply the eligibility or timing rule before comparing outputs.
3. Aggregate or rank only after the row set matches the question.
4. Use a deterministic `ORDER BY`.

## Interview phrasing
I would state the grain, name the rows that must be excluded or preserved, then explain the join, aggregate, or window function that enforces that rule.
