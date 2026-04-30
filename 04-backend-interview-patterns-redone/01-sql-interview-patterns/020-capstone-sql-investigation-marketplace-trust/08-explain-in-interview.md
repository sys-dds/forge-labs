# Explain In Interview

## Direct answer
Use `sellers, listings, orders, disputes, refunds, response_events, listing_impressions, fraud_cases` to answer: Build an investigator report assigning boost, allow, watch, suppress, or manual_review to sellers from marketplace trust signals.

## Dataset walkthrough
The base dataset includes seller 101 is strong; seller 102 is popular but dispute/refund risky; seller 103 is cold-start; seller 104 has open fraud; seller 105 has high impressions and poor bookings; seller 106 has blocked listings only; seller 107 has no recent impressions. Those rows exist so a shortcut or known-dataset query gives the wrong answer.

## Query reasoning
The solution isolates listing supply, fulfilment metrics, recent funnel events, response time, and fraud existence in CTEs, then applies treatment precedence in one final CASE.

## Common mistake
It ranks by impressions only and misses fraud, dispute, refund, response, conversion, blocked-listing, and cancellation evidence.

## Senior trade-off
Prefer visible CTEs, row-grain comments in your explanation, and deterministic ordering over a compact query that hides why rows survived.

## Follow-up answer
Ask for a second column that lists all reasons, not only the primary reason.
