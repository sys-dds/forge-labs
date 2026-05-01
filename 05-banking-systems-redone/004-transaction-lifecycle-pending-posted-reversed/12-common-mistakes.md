# Common Mistakes

- Collapsing source rows into one mutable balance or status column.
- Ignoring `transaction tx-pending-1 is pending, tx-failed-1 failed, and reversal 7001 links to tx-posted-2`.
- Returning a read model without showing the source rows that justify it.
- Treating retry safety as documentation instead of table constraints.

Interviewers catch these by asking which exact row changes the answer and by asking for a query that proves it.
