# Explain In Interview

## Direct answer
Use the `creators, creator_activity` tables to answer: Build day-1 and day-7 retention by creator signup cohort.

## Dataset walkthrough
The base dataset includes 102 active day 6 but not day 7; 104 day 7 retained; 101 day 1 and day 7 retained. These rows exist because they expose the mistake in the broken attempt.

## Query reasoning
The solution first chooses the right row set, then computes the requested metric or ranking, then orders the final result deterministically. It does not name final answer IDs.

## Common mistake
It counts any future activity as both day-1 and day-7 retained.

## Senior trade-off
Prefer a query that makes the row grain visible over a shorter query that hides which rows survived.

## Follow-up answer
Ask for week-1 retention as days 1 through 7 and compare it with exact day-7.
