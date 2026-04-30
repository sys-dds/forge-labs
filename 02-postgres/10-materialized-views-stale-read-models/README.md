# 10. Materialized Views And Stale Read-Model Trade-Offs

This chapter teaches materialized views, refresh, stale summaries through a backend-shaped dataset. Read the concept explainer first, load the chapter, then inspect the named rows before touching the proof.

## Scenario

Ben starts with one verified review, Maya adds another after materialization, normal view sees it immediately. The point is to make PostgreSQL own a narrow correctness rule that ordinary SQL alone would leave vague or application-dependent.

## Expected Behavior

The chapter proof checks stale then refreshed counts, normal view current. The common mistake file shows how to break the rule deliberately, then restore the database-owned behavior.

## Study Loop

1. Run `./scripts/forge-load-postgres.sh 02-postgres/10-materialized-views-stale-read-models`.
2. Inspect the tables and views in Adminer, DbGate, or psql.
3. Run `./scripts/forge-test-postgres.sh 02-postgres/10-materialized-views-stale-read-models`.
4. Break one line from `90-common-mistakes.sql`, confirm the proof fails, then fix it.

## Interview Target

Explain why this belongs in PostgreSQL: name the rows, name the failure mode, and name the proof that catches it.
