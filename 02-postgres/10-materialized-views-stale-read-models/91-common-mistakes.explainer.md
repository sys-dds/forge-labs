# Common Mistakes

## App-Only Rule

The tempting shortcut is to check `expecting materialized view to refresh itself, using stale view for safety checks` in one application handler. That misses imports, retries, admin scripts, and future services. The chapter proof forces the database behavior to be visible.

## Generic Projection

Returning every column or every joined row hides whether the PostgreSQL feature did its job. Shape the result so Ada, Ben, Cy, or Maya can be explained row by row.

## Weak Proof

A proof that only checks that some row exists would pass even if the unsafe row leaked. The proof in this chapter checks exact rows, counts, or rejected writes.

## Interview Repair

Say which named row is valid, which named row is unsafe, and which PostgreSQL feature owns the boundary.
