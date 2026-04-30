# Explain In Interview

## Direct answer
I would solve this with senior investigation query combining metrics, latest rows, reconciliation, transition debugging, and ratio safety, deriving the returned rows from table relationships and business thresholds rather than known IDs.

## Dataset walkthrough
Ben should boost, Omar has fraud, Diya has high impressions with low booking, Maya has a ledger mismatch, Lina has invalid transitions, Noor has no recent impressions, Cy has blocked listings only, and Theo is cold-start.

## Query reasoning
Build seller metric CTEs, latest moderation with DISTINCT ON, FULL OUTER reconciliation counts, LAG transition counts, safe rates, and a treatment CASE.

## Common mistake
The broken query ranks by impressions and ignores fraud, reconciliation, moderation, and state transitions.

## Follow-up answer
A follow-up may ask you to split this report into reusable audited views.
