# 12. PL/pgSQL Functions For Controlled Mutations

This chapter teaches PL/pgSQL, exceptions, audit writes, controlled mutation through a backend-shaped dataset. Read the concept explainer first, load the chapter, then inspect the named rows before touching the proof.

## Scenario

Cy dispute starts open, Maya resolves it, invalid repeat resolution is attempted. The point is to make PostgreSQL own a narrow correctness rule that ordinary SQL alone would leave vague or application-dependent.

## Expected Behavior

The chapter proof checks status changes, audit row inserted, invalid transition rejected. The common mistake file shows how to break the rule deliberately, then restore the database-owned behavior.

## Study Loop

1. Run `./scripts/forge-load-postgres.sh 02-postgres/12-plpgsql-functions-controlled-mutations`.
2. Inspect the tables and views in Adminer, DbGate, or psql.
3. Run `./scripts/forge-test-postgres.sh 02-postgres/12-plpgsql-functions-controlled-mutations`.
4. Break one line from `90-common-mistakes.sql`, confirm the proof fails, then fix it.

## Interview Target

Explain why this belongs in PostgreSQL: name the rows, name the failure mode, and name the proof that catches it.
