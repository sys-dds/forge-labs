# Explain In Interview

## Direct answer
Use `price_events` to answer: Find listings whose price dropped by at least 20 percent compared with their immediately previous price event.

## Dataset walkthrough
The base dataset includes listing 101 has a later large drop after a small drop; listing 102 increases; listing 103 has only a small drop; listing 104 has one price event; listing 105 has same-timestamp events that require event_id tie-break. Those rows exist so a shortcut or known-dataset query gives the wrong answer.

## Query reasoning
The solution ranks price events per listing by changed_at and price_event_id, self joins each row to sequence minus one, then calculates the immediate drop.

## Common mistake
It compares each price to the maximum historical price, not the immediately previous price event.

## Senior trade-off
Prefer visible CTEs, row-grain comments in your explanation, and deterministic ordering over a compact query that hides why rows survived.

## Follow-up answer
Ask for only the latest qualifying drop per listing.
