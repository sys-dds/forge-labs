# Explain In Interview

## Direct answer
Use the `listings` tables to answer: Find the top available listings in Glasgow, excluding blocked listings, sold listings, and listings with missing price.

## Dataset walkthrough
The base dataset includes 103 NULL price; 104 sold; 105 blocked; 106 and 108 tie by price and listing_id. These rows exist because they expose the mistake in the broken attempt.

## Query reasoning
The solution first chooses the right row set, then computes the requested metric or ranking, then orders the final result deterministically. It does not name final answer IDs.

## Common mistake
It orders by price before filtering eligibility, so NULL, sold, or blocked rows can leak into the top results.

## Senior trade-off
Prefer a query that makes the row grain visible over a shorter query that hides which rows survived.

## Follow-up answer
Ask for cheapest eligible listing instead of highest quality, and change the ORDER BY only after keeping the filters.
