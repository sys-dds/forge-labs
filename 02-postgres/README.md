# 02 Postgres

This path starts after `01-sql`. SQL taught rows, joins, aggregation, graph traversal, pagination, recursive queries, and proof tests. PostgreSQL now teaches database-owned backend behavior: richer types, constraints, upserts, JSONB, generated columns, views, functions, triggers, RLS, advisory locks, notifications, and schema hygiene.

## Modes

- Chapter mode: numbered folders teach one PostgreSQL feature with runnable SQL and proof tests.
- Practice mode: `_practice` packs rehearse one feature as a guided backend task.
- Gauntlet mode: `_gauntlet` packs start from broken PostgreSQL behavior and repair it.
- Interview drills: `_interview-drills` trains concrete explanation with named rows.
- Self-assessment: `_self-assessment` maps weak spots before database optimisation.

## Commands

```bash
./scripts/forge-list-postgres.sh
./scripts/forge-load-postgres.sh 02-postgres/06-insert-on-conflict-idempotent-writes
./scripts/forge-test-postgres.sh 02-postgres/17-advisory-locks-local-coordination
./scripts/forge-test-all-postgres.sh
./scripts/forge-verify-postgres.sh
```

Adminer runs on http://localhost:8081 and DbGate on http://localhost:8082 after `./scripts/forge-up.sh sql` or Docker Compose startup. Connect to database `forge_labs` with user `forge_labs` and password `forge_labs`.
