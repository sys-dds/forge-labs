# Explain In Interview

## Direct answer
Use the `listing_status_events` tables to answer: Return each listing latest status and exclude listings whose latest status is removed or sold.

## Dataset walkthrough
The base dataset includes 102 latest sold; 103 duplicate timestamp tie by event_id removed; 105 older sold then latest available. These rows exist because they expose the mistake in the broken attempt.

## Query reasoning
The solution first chooses the right row set, then computes the requested metric or ranking, then orders the final result deterministically. It does not name final answer IDs.

## Common mistake
It aggregates status and timestamp separately, creating statuses that do not necessarily belong to the latest event row.

## Senior trade-off
Prefer a query that makes the row grain visible over a shorter query that hides which rows survived.

## Follow-up answer
Ask how the answer changes when identical timestamps should prefer a status priority instead of event_id.
