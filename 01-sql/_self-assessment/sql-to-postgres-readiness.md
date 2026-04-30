# SQL-to-Postgres Readiness

You are ready to move from general SQL to PostgreSQL-specific work when:

- all local SQL mastery verification passes
- you can explain every exclusion in the feed, social graph, and matching packs
- you can repair row multiplication without reaching for random `DISTINCT`
- you can write keyset cursors with deterministic tie-breakers
- you can scope recursive CTEs safely
- you can explain what a proof test should catch before writing the query

Do not move on if you still guess at join direction, count joined rows without knowing the grain, or cannot explain why a specific named row is absent.
