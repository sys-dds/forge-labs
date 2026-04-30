# 02. UUID, TIMESTAMPTZ, NUMERIC, Domain-Safe Values

This chapter teaches uuid defaults, timestamptz comparisons, numeric exactness, CHECK constraints through a backend-shaped dataset. Read the concept explainer first, load the chapter, then inspect the named rows before touching the proof.

## Scenario

Ada sends duplicate external requests, Ben receives exact decimal payment-boundary amounts, Cy sends an empty external reference attempt. The point is to make PostgreSQL own a narrow correctness rule that ordinary SQL alone would leave vague or application-dependent.

## Expected Behavior

The chapter proof checks uuid uniqueness, exact arithmetic, rejected negative amounts, rejected empty references. The common mistake file shows how to break the rule deliberately, then restore the database-owned behavior.

## Study Loop

1. Run `./scripts/forge-load-postgres.sh 02-postgres/02-uuid-timestamptz-numeric-domain-values`.
2. Inspect the tables and views in Adminer, DbGate, or psql.
3. Run `./scripts/forge-test-postgres.sh 02-postgres/02-uuid-timestamptz-numeric-domain-values`.
4. Break one line from `90-common-mistakes.sql`, confirm the proof fails, then fix it.

## Interview Target

Explain why this belongs in PostgreSQL: name the rows, name the failure mode, and name the proof that catches it.
