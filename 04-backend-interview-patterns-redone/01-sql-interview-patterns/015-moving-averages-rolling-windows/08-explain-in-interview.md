# Explain In Interview

## Direct answer
Use `daily_listing_impressions` to answer: Compute a 3-day moving average of impressions per listing using explicit daily rows in the dataset.

## Dataset walkthrough
The base dataset includes listing 101 has a zero-impression day; listing 101 skips a calendar day; listing 102 has a full 3-day window; multiple listings are partitioned separately. Those rows exist so a shortcut or known-dataset query gives the wrong answer.

## Query reasoning
The solution partitions by listing, orders by activity_date, and averages the current row plus two preceding rows.

## Common mistake
It uses one AVG over all rows for the listing instead of a rolling three-row frame.

## Senior trade-off
Prefer visible CTEs, row-grain comments in your explanation, and deterministic ordering over a compact query that hides why rows survived.

## Follow-up answer
Ask for a calendar date spine first, then the same moving average over zero-filled days.
