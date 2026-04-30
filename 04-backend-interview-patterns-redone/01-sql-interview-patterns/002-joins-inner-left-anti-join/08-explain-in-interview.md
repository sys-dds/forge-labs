# Explain In Interview

## Direct answer
Use the `users, required_checks, user_checks` tables to answer: Find active users who have not completed every required identity check.

## Dataset walkthrough
The base dataset includes 102 missing address; 104 no checks; 103 failed identity; 105 inactive excluded. These rows exist because they expose the mistake in the broken attempt.

## Query reasoning
The solution first chooses the right row set, then computes the requested metric or ranking, then orders the final result deterministically. It does not name final answer IDs.

## Common mistake
It uses an INNER JOIN to existing checks, so users with no check rows disappear.

## Senior trade-off
Prefer a query that makes the row grain visible over a shorter query that hides which rows survived.

## Follow-up answer
Ask for one row per missing check rather than a count, keeping the same anti-join shape.
