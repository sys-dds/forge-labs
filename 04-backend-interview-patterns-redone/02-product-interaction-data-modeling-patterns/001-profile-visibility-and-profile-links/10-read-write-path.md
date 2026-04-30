# Read Write Path

## Write path
Create the user, create one profile row, insert one visibility row per field, and insert block rows when the owner blocks a viewer.

## Read path
`05-verification-query.sql` is the contract read. It joins the source tables and lifecycle state to prove the expected product behaviour.

## Transaction and constraint note
Write the relationship/event row and any derived counter in one transaction later; this clinic derives counters directly so the source-of-truth model stays obvious.
