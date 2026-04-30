# Explain In Interview

## Direct answer
I would solve this with JOIN LATERAL for top related row per parent, deriving the returned rows from table relationships and business thresholds rather than known IDs.

## Dataset walkthrough
Buyer 1 has exact Glasgow plumbing choices, buyer 2 has a blocked cheapest seller, buyer 3 needs an above-budget fallback, and buyer 4 has no valid match.

## Query reasoning
For each buyer row, use LEFT JOIN LATERAL to rank only that buyer’s valid listings by budget fit, trust, distance, and listing id.

## Common mistake
The broken query uses one global LIMIT, so every buyer receives the same listing.

## Follow-up answer
A follow-up may ask you to return the top 3 matches per buyer instead of one.
