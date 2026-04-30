# Explain In Interview

## Direct answer
I would solve this with FULL OUTER JOIN reconciliation between systems, deriving the returned rows from table relationships and business thresholds rather than known IDs.

## Dataset walkthrough
Order 1002 has no ledger, ledger 9003 has no order, order 1004 has an amount mismatch, order 1005 has a refund posting mismatch, and cancelled order 1006 needs no ledger.

## Query reasoning
FULL OUTER JOIN by order id, keep rows with missing sides, amount differences, or status/posting-type disagreements.

## Common mistake
The broken INNER JOIN can only see rows that exist in both systems, so missing ledger and extra ledger disappear.

## Follow-up answer
A follow-up may ask you to split missing rows and amount rows into separate exception tables.
