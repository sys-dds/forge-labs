# 15. Row Level Security Tenant Boundaries

This chapter teaches RLS enablement, current_setting tenant context, app role policies through a backend-shaped dataset. Read the concept explainer first, load the chapter, then inspect the named rows before touching the proof.

## Scenario

Workspace alpha has Ada listing, beta has Ben listing, app_user switches tenant context. The point is to make PostgreSQL own a narrow correctness rule that ordinary SQL alone would leave vague or application-dependent.

## Expected Behavior

The chapter proof checks alpha sees alpha only, beta sees beta only, no context sees nothing. The common mistake file shows how to break the rule deliberately, then restore the database-owned behavior.

## Study Loop

1. Run `./scripts/forge-load-postgres.sh 02-postgres/15-row-level-security-tenant-boundaries`.
2. Inspect the tables and views in Adminer, DbGate, or psql.
3. Run `./scripts/forge-test-postgres.sh 02-postgres/15-row-level-security-tenant-boundaries`.
4. Break one line from `90-common-mistakes.sql`, confirm the proof fails, then fix it.

## Interview Target

Explain why this belongs in PostgreSQL: name the rows, name the failure mode, and name the proof that catches it.
