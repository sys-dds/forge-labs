# Explain In Interview

## Direct answer
I would solve this with keyset pagination using a composite cursor, deriving the returned rows from table relationships and business thresholds rather than known IDs.

## Dataset walkthrough
There are duplicate scores around the cursor, a blocked listing after the cursor, and lower-score listings that fill the next page.

## Query reasoning
Use the composite predicate for descending score and ascending listing id, then order by the same keys and limit 3.

## Common mistake
The broken OFFSET query can return the cursor row or shift when rows are inserted before the cursor.

## Follow-up answer
A follow-up may ask how to encode the cursor for a public API without exposing internals.
