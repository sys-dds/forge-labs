# How To Study

Start by reading `03-question.md`, then inspect `01-schema.sql`, `02-seed.sql`, and `02b-seed-variant.sql`. Predict the output before opening `06-expected-output.csv`. Run the broken attempt to see the trap, then run the solution and compare both CSVs.

For each clinic, say the pattern out loud: what tables are joined, what rows are excluded, what grouping grain is used, and what ORDER BY makes the answer deterministic.
## Advanced SQL Interview Patterns 011-020

Clinics 011-020 extend the lab with CTE decomposition, EXISTS and NOT EXISTS, self-comparison, running totals, rolling windows, ranking buckets, date spines, sessionization, effective-dated joins, and marketplace trust investigation queries. The same Docker/Postgres runner and base-plus-variant proof strategy from 001-010 still applies.
