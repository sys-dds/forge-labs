# Pattern

## What this clinic practices
keyset pagination using a composite cursor.

## Actual tables
`listings` contains ranked marketplace rows and `page_cursor` stores the last score/listing returned.

## Actual rows that trap the learner
There are duplicate scores around the cursor, a blocked listing after the cursor, and lower-score listings that fill the next page.

## Why the broken query fails
The broken OFFSET query can return the cursor row or shift when rows are inserted before the cursor.

## Correct query shape
Use the composite predicate for descending score and ascending listing id, then order by the same keys and limit 3.

## Interview wording
Name the relational rule first, then name the guardrail that keeps the answer stable across the variant seed.
