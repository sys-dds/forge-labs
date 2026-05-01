# Common Mistakes

- Collapsing source rows into one mutable balance or status column.
- Ignoring `ledger transaction 9002 is intentionally unbalanced and account 101 derives balance from ledger_entries`.
- Returning a read model without showing the source rows that justify it.
- Treating retry safety as documentation instead of table constraints.

Interviewers catch these by asking which exact row changes the answer and by asking for a query that proves it.
