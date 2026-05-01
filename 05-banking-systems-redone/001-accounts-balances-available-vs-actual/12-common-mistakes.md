# Common Mistakes

- Collapsing source rows into one mutable balance or status column.
- Ignoring `Ada account 101 has a pending hold, a released hold, an expired hold, and closed account 102 is excluded`.
- Returning a read model without showing the source rows that justify it.
- Treating retry safety as documentation instead of table constraints.

Interviewers catch these by asking which exact row changes the answer and by asking for a query that proves it.
