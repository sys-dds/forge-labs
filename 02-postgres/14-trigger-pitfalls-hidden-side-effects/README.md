# 14. Trigger Pitfalls And Hidden Side Effects

This chapter teaches trigger side effects, WHEN guards, bulk update visibility through a backend-shaped dataset. Read the concept explainer first, load the chapter, then inspect the named rows before touching the proof.

## Scenario

Ben and Cy listings are bulk-paused, no-op update is ignored by trigger guard. The point is to make PostgreSQL own a narrow correctness rule that ordinary SQL alone would leave vague or application-dependent.

## Expected Behavior

The chapter proof checks bulk update audit count, no-op ignored, no recursion marker. The common mistake file shows how to break the rule deliberately, then restore the database-owned behavior.

## Study Loop

1. Run `./scripts/forge-load-postgres.sh 02-postgres/14-trigger-pitfalls-hidden-side-effects`.
2. Inspect the tables and views in Adminer, DbGate, or psql.
3. Run `./scripts/forge-test-postgres.sh 02-postgres/14-trigger-pitfalls-hidden-side-effects`.
4. Break one line from `90-common-mistakes.sql`, confirm the proof fails, then fix it.

## Interview Target

Explain why this belongs in PostgreSQL: name the rows, name the failure mode, and name the proof that catches it.
