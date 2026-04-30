# Explain In Interview

## Direct answer
Use the `posts` tables to answer: Return the top 2 safe, non-deleted posts per topic by score.

## Dataset walkthrough
The base dataset includes 103 unsafe high score; 203 deleted high score; 101/102 tie by post_id. These rows exist because they expose the mistake in the broken attempt.

## Query reasoning
The solution first chooses the right row set, then computes the requested metric or ranking, then orders the final result deterministically. It does not name final answer IDs.

## Common mistake
It applies a global LIMIT 2, returning only the two highest posts overall instead of two per topic.

## Senior trade-off
Prefer a query that makes the row grain visible over a shorter query that hides which rows survived.

## Follow-up answer
Ask for top 3 per topic or DENSE_RANK when ties should share rank.
