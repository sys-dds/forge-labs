# Explain In Interview

## Direct answer
Use the `creators, posts` tables to answer: Find creators with at least 3 published posts and at least 2 published posts with meaningful engagement.

## Dataset walkthrough
The base dataset includes 102 has NULL and low engagement; 104 has draft/deleted rows; 101 has one zero engagement row. These rows exist because they expose the mistake in the broken attempt.

## Query reasoning
The solution first chooses the right row set, then computes the requested metric or ranking, then orders the final result deterministically. It does not name final answer IDs.

## Common mistake
It counts every joined row, including draft and deleted posts, and treats total rows as meaningful engagement.

## Senior trade-off
Prefer a query that makes the row grain visible over a shorter query that hides which rows survived.

## Follow-up answer
Ask for creators with exactly one weak published post and reuse conditional aggregation.
