# Read Write Path

## Write path
Insert swipe event; when a reciprocal latest right exists and no block/report exists, create one canonical match row.

## Read path
`05-verification-query.sql` is the contract read. It joins the source tables and lifecycle state to prove the expected product behaviour.

## Transaction and constraint note
Write the relationship/event row and any derived counter in one transaction later; this clinic derives counters directly so the source-of-truth model stays obvious.
