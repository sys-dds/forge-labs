# Explain In Interview

## Direct answer
Use the `funnel_events` tables to answer: Calculate users who viewed listing, contacted seller, booked order, and completed order in order.

## Dataset walkthrough
The base dataset includes 103 contacts before view; 102 skips contacted; 104 repeats contacted; 105 reaches booking only. These rows exist because they expose the mistake in the broken attempt.

## Query reasoning
The solution first chooses the right row set, then computes the requested metric or ranking, then orders the final result deterministically. It does not name final answer IDs.

## Common mistake
It counts each event type independently, so out-of-order and skipped steps inflate later funnel stages.

## Senior trade-off
Prefer a query that makes the row grain visible over a shorter query that hides which rows survived.

## Follow-up answer
Ask for per-user funnel_state rows before the aggregate counts.

The `funnel_steps` table provides the interview step labels and their deterministic order, so the query does not manufacture final rows from string literals.
