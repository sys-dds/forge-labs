# Explain In Interview

## Direct answer
I would solve this with conditional aggregation to pivot event rows into metric columns, deriving the returned rows from table relationships and business thresholds rather than known IDs.

## Dataset walkthrough
Ben has all statuses, Diya has zero orders, Omar has only cancelled orders, Maya has a refunded order, and a test order must be excluded.

## Query reasoning
LEFT JOIN weekly non-test orders and use COUNT/SUM FILTER expressions for each metric column.

## Common mistake
The broken query filters completed orders before aggregation, losing cancellations, disputes, refunds, and zero-order sellers.

## Follow-up answer
A follow-up may ask you to pivot by day of week as well as status.
