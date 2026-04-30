# Common SQL Traps

- `NULL` does not equal a number; filter missing prices explicitly.
- `INNER JOIN` removes missing relationships; anti-joins need preserved rows.
- `COUNT(*)` and `COUNT(column)` answer different questions.
- A `WHERE` filter before aggregation can delete evidence needed for other metrics.
- Global `LIMIT` is not top-N per group.
- `MAX(timestamp)` does not return the whole latest row unless you rank the row.
- Retention and funnel queries need exact time windows and event order.
## Advanced SQL Interview Patterns 011-020

Clinics 011-020 extend the lab with CTE decomposition, EXISTS and NOT EXISTS, self-comparison, running totals, rolling windows, ranking buckets, date spines, sessionization, effective-dated joins, and marketplace trust investigation queries. The same Docker/Postgres runner and base-plus-variant proof strategy from 001-010 still applies.

## Senior SQL Correctness Patterns 021-030

Clinics 021-030 add recursive CTEs, set operations, reconciliation, DISTINCT ON, LATERAL matching, pivot metrics, keyset pagination, state-transition debugging, safe ratios, and a senior investigation capstone. Study them after 001-020 because every query still uses the same base/variant proof loop.
