# 05. Exclusion Constraints And Temporal Overlaps

This chapter teaches range types, btree_gist, exclusion constraints through a backend-shaped dataset. Read the concept explainer first, load the chapter, then inspect the named rows before touching the proof.

## Scenario

Ben accepts 09:00 booking, adjacent 10:00 booking, Cy accepts overlapping window, Ada tries overlapping Ben booking. The point is to make PostgreSQL own a narrow correctness rule that ordinary SQL alone would leave vague or application-dependent.

## Expected Behavior

The chapter proof checks adjacent allowed, same-provider overlap rejected, other provider allowed. The common mistake file shows how to break the rule deliberately, then restore the database-owned behavior.

## Study Loop

1. Run `./scripts/forge-load-postgres.sh 02-postgres/05-exclusion-constraints-temporal-overlaps`.
2. Inspect the tables and views in Adminer, DbGate, or psql.
3. Run `./scripts/forge-test-postgres.sh 02-postgres/05-exclusion-constraints-temporal-overlaps`.
4. Break one line from `90-common-mistakes.sql`, confirm the proof fails, then fix it.

## Interview Target

Explain why this belongs in PostgreSQL: name the rows, name the failure mode, and name the proof that catches it.
