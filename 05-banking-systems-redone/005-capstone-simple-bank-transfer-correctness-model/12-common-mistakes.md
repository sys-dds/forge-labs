# Common Mistakes

- Collapsing source rows into one mutable balance or status column.
- Ignoring `Ada account 101 has a hold, transfer 3001 has a duplicate retry, key idem-cap-002 conflicts, pending and failed transactions do not post, and reversal 7001 links original movement`.
- Returning a read model without showing the source rows that justify it.
- Treating retry safety as documentation instead of table constraints.

Interviewers catch these by asking which exact row changes the answer and by asking for a query that proves it.
