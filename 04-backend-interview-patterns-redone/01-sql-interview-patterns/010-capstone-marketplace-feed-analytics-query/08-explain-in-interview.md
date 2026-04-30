# Explain In Interview

## Direct answer
Use the `sellers, listings, orders, listing_events` tables to answer: For each seller, compute marketplace feed metrics and assign boost, allow, watch, or suppress.

## Dataset walkthrough
The base dataset includes 101 high quality boost; 102 popular risky suppress; 103 cold-start allow; 104 high impressions poor booking watch; 105 blocked listing excluded; 106 no recent impressions. These rows exist because they expose the mistake in the broken attempt.

## Query reasoning
The solution first chooses the right row set, then computes the requested metric or ranking, then orders the final result deterministically. It does not name final answer IDs.

## Common mistake
It ranks by impressions only and ignores fulfilment, response, blocked listings, and conversion rates.

## Senior trade-off
Prefer a query that makes the row grain visible over a shorter query that hides which rows survived.

## Follow-up answer
Ask for a separate reason column explaining which treatment rule fired.
