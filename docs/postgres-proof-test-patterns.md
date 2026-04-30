# PostgreSQL Proof Test Patterns

Prefer exact proof assertions:

- exact rows from a view
- exact counts after exclusions
- rejected invalid inserts or updates
- RLS checks through an application role
- stale versus refreshed read-model checks
- trigger audit rows with old and new values

A useful proof fails when the database-owned rule is removed.
