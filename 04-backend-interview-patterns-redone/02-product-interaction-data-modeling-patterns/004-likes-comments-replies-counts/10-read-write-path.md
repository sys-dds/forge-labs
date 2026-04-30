# Read Write Path

## Write path
Insert reaction events, append comments/replies, and soft-delete by setting `deleted_at` instead of deleting history.

## Read path
`05-verification-query.sql` is the contract read. It joins the source tables and lifecycle state to prove the expected product behaviour.

## Transaction and constraint note
Write the relationship/event row and any derived counter in one transaction later; this clinic derives counters directly so the source-of-truth model stays obvious.
