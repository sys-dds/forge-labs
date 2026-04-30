# PostgreSQL vs SQL

`01-sql` teaches the language patterns that work across relational databases. `02-postgres` teaches features where PostgreSQL itself becomes part of backend correctness.

Use this path when the question is not only “which rows should a query return?” but also “which writes should be impossible?”, “which payload shape is acceptable?”, “which tenant can see this row?”, or “which worker may claim this job?”.

This path intentionally avoids deep EXPLAIN and index tuning. Optimisation comes after the learner can explain the correctness boundary.
