# SQL Practice Mode

Practice mode is the lab bench beside the chapter path. Chapters teach one idea at a time. Practice packs ask you to load a small scenario, inspect the rows, run a candidate solution, prove the behavior, break the query on purpose, and restore it.

Each pack is independent. It owns its schema, seed data, starter query, solution, proof tests, expected results, break/fix drills, and interview explanation target. You can run one pack without loading its source chapter first.

## Workflow

Start the local PostgreSQL stack:

```bash
./scripts/forge-up.sh
```

List available practice packs:

```bash
./scripts/forge-list-practice.sh
```

Inspect a pack before loading it:

```bash
./scripts/forge-inspect-practice.sh 01-sql/_practice/01-social-graph-suggestions
```

Load a pack for study:

```bash
./scripts/forge-load-practice.sh 01-sql/_practice/01-social-graph-suggestions
```

Run the solution and proof tests:

```bash
./scripts/forge-test-practice.sh 01-sql/_practice/01-social-graph-suggestions
```

Reset the practice database instantly:

```bash
./scripts/forge-reset-practice.sh
```

Adminer runs at `http://localhost:8081`. DbGate runs at `http://localhost:8082`. Use database `forge_labs`, user `forge_labs`, password `forge_labs`, host `forge-labs-postgres` inside DbGate or `localhost` from a local SQL client.

## Challenge Packs

| Pack | Backend idea | Source chapter |
| --- | --- | --- |
| `01-social-graph-suggestions` | Directed graph traversal with safety exclusions | `01-sql/04-followers-and-social-graph` |
| `02-feed-candidate-debugging` | Candidate filtering before ranking and safe aggregate joins | `01-sql/05-joins-and-feed-candidates` |
| `03-keyset-pagination-scroll` | Stable cursor pagination after new inserts | `01-sql/08-pagination-and-cursors` |
| `04-matching-candidate-filtering` | Matching exclusions before preference fit | `01-sql/10-matching-sql-swipes-and-mutual-matches` |

## File Order

Read each pack in this order:

1. `challenge.manifest`
2. `00-scenario.md`
3. `01-schema.sql`
4. `02-seed.sql`
5. `03-starting-point.sql`
6. `04-solution.sql`
7. `05-proof.tests.sql`
8. `06-expected-results.md`
9. `07-break-fix-drills.md`
10. `08-interview-explanation.md`
