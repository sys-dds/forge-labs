# Pattern

## What this clinic teaches
consecutive-day streaks using date arithmetic and windows.

## Actual tables
`users, practice_events`.

## Actual rows that create the trap
101 duplicate same day; 101 skipped day then three-day streak; 104 active no events; 105 inactive excluded.

## Why the broken query fails
It counts total active days, not consecutive days, so skipped days inflate the streak.

## Correct query steps
1. Read the rows at the correct grain.
2. Apply the eligibility or timing rule before comparing outputs.
3. Aggregate or rank only after the row set matches the question.
4. Use a deterministic `ORDER BY`.

## Interview phrasing
I would state the grain, name the rows that must be excluded or preserved, then explain the join, aggregate, or window function that enforces that rule.
