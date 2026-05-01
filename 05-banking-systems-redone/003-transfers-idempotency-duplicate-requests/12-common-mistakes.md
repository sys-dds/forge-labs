# Common Mistakes

- Collapsing source rows into one mutable balance or status column.
- Ignoring `idempotency key idem-rent-001 has a retry and a conflicting fingerprint attempt`.
- Returning a read model without showing the source rows that justify it.
- Treating retry safety as documentation instead of table constraints.

Interviewers catch these by asking which exact row changes the answer and by asking for a query that proves it.
