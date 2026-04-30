# 16. RLS Policy Mistakes And Proof Tests

This chapter teaches USING vs WITH CHECK, read/write policies, tenant insert protection through a backend-shaped dataset. Read the concept explainer first, load the chapter, then inspect the named rows before touching the proof.

## Scenario

Alpha and beta workspaces, app_user tries cross-tenant insert and update. The point is to make PostgreSQL own a narrow correctness rule that ordinary SQL alone would leave vague or application-dependent.

## Expected Behavior

The chapter proof checks wrong-tenant read/insert/update denied, correct action allowed. The common mistake file shows how to break the rule deliberately, then restore the database-owned behavior.

## Study Loop

1. Run `./scripts/forge-load-postgres.sh 02-postgres/16-rls-policy-mistakes-proof-tests`.
2. Inspect the tables and views in Adminer, DbGate, or psql.
3. Run `./scripts/forge-test-postgres.sh 02-postgres/16-rls-policy-mistakes-proof-tests`.
4. Break one line from `90-common-mistakes.sql`, confirm the proof fails, then fix it.

## Interview Target

Explain why this belongs in PostgreSQL: name the rows, name the failure mode, and name the proof that catches it.
