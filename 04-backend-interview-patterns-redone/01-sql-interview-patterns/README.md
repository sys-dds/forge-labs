# SQL Interview Patterns

Clinics 001-010 cover core SQL interview patterns with concrete marketplace, creator, and practice-activity data. Each clinic has a base seed and a variant seed; the same solution query must pass both so answers come from relational rules rather than fixed IDs.

Use `./scripts/bip-sql-up.sh`, `./scripts/bip-sql-list.sh`, `./scripts/bip-sql-test-one.sh <clinic>`, and `./scripts/bip-sql-test-all.sh`.
## Advanced SQL Interview Patterns 011-020

Clinics 011-020 extend the lab with CTE decomposition, EXISTS and NOT EXISTS, self-comparison, running totals, rolling windows, ranking buckets, date spines, sessionization, effective-dated joins, and marketplace trust investigation queries. The same Docker/Postgres runner and base-plus-variant proof strategy from 001-010 still applies.

## Senior SQL Correctness Patterns 021-030

Clinics 021-030 add recursive CTEs, set operations, reconciliation, DISTINCT ON, LATERAL matching, pivot metrics, keyset pagination, state-transition debugging, safe ratios, and a senior investigation capstone. Study them after 001-020 because every query still uses the same base/variant proof loop.
