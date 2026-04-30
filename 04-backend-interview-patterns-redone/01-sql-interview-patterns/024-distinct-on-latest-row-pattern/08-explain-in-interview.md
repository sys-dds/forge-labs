# Explain In Interview

## Direct answer
I would solve this with PostgreSQL DISTINCT ON for latest-row-per-entity, deriving the returned rows from table relationships and business thresholds rather than known IDs.

## Dataset walkthrough
Listing 101 has multiple decisions, listing 102 has a same-timestamp tie, listing 103 is deleted, and listing 104 has no decision.

## Query reasoning
Use DISTINCT ON ordered by listing, decided_at descending, and decision_id descending, then left join to non-deleted listings.

## Common mistake
The broken GROUP BY MAX timestamp duplicates listing 102 because two decisions share the same timestamp.

## Follow-up answer
A follow-up may ask for ROW_NUMBER when portability matters outside PostgreSQL.
