# 04. Advanced Constraints And Partial Uniqueness

This chapter teaches composite uniqueness, partial unique indexes, CHECK constraints through a backend-shaped dataset. Read the concept explainer first, load the chapter, then inspect the named rows before touching the proof.

## Scenario

Ben has active bicycle-repair listing, Ben also has removed history with same slug, Cy uses same slug safely. The point is to make PostgreSQL own a narrow correctness rule that ordinary SQL alone would leave vague or application-dependent.

## Expected Behavior

The chapter proof checks duplicate active slug rejected, removed history allowed, different seller allowed, invalid price rejected. The common mistake file shows how to break the rule deliberately, then restore the database-owned behavior.

## Study Loop

1. Run `./scripts/forge-load-postgres.sh 02-postgres/04-advanced-constraints-partial-uniqueness`.
2. Inspect the tables and views in Adminer, DbGate, or psql.
3. Run `./scripts/forge-test-postgres.sh 02-postgres/04-advanced-constraints-partial-uniqueness`.
4. Break one line from `90-common-mistakes.sql`, confirm the proof fails, then fix it.

## Interview Target

Explain why this belongs in PostgreSQL: name the rows, name the failure mode, and name the proof that catches it.
