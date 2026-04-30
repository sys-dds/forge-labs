# 06. Insert On Conflict And Idempotent Writes

This chapter teaches ON CONFLICT DO NOTHING, DO UPDATE, scoped idempotency keys through a backend-shaped dataset. Read the concept explainer first, load the chapter, then inspect the named rows before touching the proof.

## Scenario

Ada retries create request, Ben uses the same key in a different actor scope, status update is retried. The point is to make PostgreSQL own a narrow correctness rule that ordinary SQL alone would leave vague or application-dependent.

## Expected Behavior

The chapter proof checks duplicate does not duplicate, scoped key works, mutable status updates only. The common mistake file shows how to break the rule deliberately, then restore the database-owned behavior.

## Study Loop

1. Run `./scripts/forge-load-postgres.sh 02-postgres/06-insert-on-conflict-idempotent-writes`.
2. Inspect the tables and views in Adminer, DbGate, or psql.
3. Run `./scripts/forge-test-postgres.sh 02-postgres/06-insert-on-conflict-idempotent-writes`.
4. Break one line from `90-common-mistakes.sql`, confirm the proof fails, then fix it.

## Interview Target

Explain why this belongs in PostgreSQL: name the rows, name the failure mode, and name the proof that catches it.
