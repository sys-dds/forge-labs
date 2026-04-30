# Common SQL Traps

- `NULL` does not equal a number; filter missing prices explicitly.
- `INNER JOIN` removes missing relationships; anti-joins need preserved rows.
- `COUNT(*)` and `COUNT(column)` answer different questions.
- A `WHERE` filter before aggregation can delete evidence needed for other metrics.
- Global `LIMIT` is not top-N per group.
- `MAX(timestamp)` does not return the whole latest row unless you rank the row.
- Retention and funnel queries need exact time windows and event order.
