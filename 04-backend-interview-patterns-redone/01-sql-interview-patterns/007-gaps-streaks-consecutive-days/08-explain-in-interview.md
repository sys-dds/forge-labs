# Explain In Interview

## Direct answer
Use the `users, practice_events` tables to answer: Find each active user longest SQL practice streak.

## Dataset walkthrough
The base dataset includes 101 duplicate same day; 101 skipped day then three-day streak; 104 active no events; 105 inactive excluded. These rows exist because they expose the mistake in the broken attempt.

## Query reasoning
The solution first chooses the right row set, then computes the requested metric or ranking, then orders the final result deterministically. It does not name final answer IDs.

## Common mistake
It counts total active days, not consecutive days, so skipped days inflate the streak.

## Senior trade-off
Prefer a query that makes the row grain visible over a shorter query that hides which rows survived.

## Follow-up answer
Ask for current streak ending today and explain why the grouping changes.
