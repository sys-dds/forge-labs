# Forge Labs

Forge Labs is a never-ending backend learning workshop for backend fundamentals. It is intentionally not a portfolio app, not a product clone, and not a question bank. The repo exists to make fundamentals feel concrete by connecting each concept to backend work you would actually do.

The repository currently includes the original **01-sql** path plus redone backend interview tracks such as `04-backend-interview-patterns-redone/`. SQL still starts the workshop because it is where backend systems discover rows, protect invariants, apply visibility rules, count behavior, paginate feeds, and prepare candidates for ranking or matching.

## Why Implementation-First

Every chapter contains working solution SQL and proof tests. The study loop is read the implemented solution, run it, inspect the database, study the mistakes, break one thing deliberately, fix it, then add one small extension. That keeps the learner out of blank-page mode while still making them work with real code.

## Test Mode

Use test mode when you want confidence that every chapter still proves its concept:

```bash
./scripts/forge-up.sh sql
./scripts/run-all-sql-chapters.sh
./scripts/forge-down.sh
```

## Study Mode

Use study mode when you want to load one chapter and inspect tables/views manually:

```bash
./scripts/forge-up.sh sql
./scripts/forge-load.sh 01-sql/04-followers-and-social-graph
./scripts/forge-inspect.sh 01-sql/04-followers-and-social-graph
```

Then open Adminer at http://localhost:8081 or DbGate at http://localhost:8082. Connect with database `forge_labs`, user `forge_labs`, and password `forge_labs`.

## Practice Mode

Use practice mode after a chapter idea is familiar and you want to work it like a backend debugging task. Practice packs live under `01-sql/_practice/`. Each pack has its own schema, seed data, starter query, solution, proof tests, expected results, break/fix drills, and interview explanation.

```bash
./scripts/forge-up.sh sql
./scripts/forge-list-practice.sh
./scripts/forge-inspect-practice.sh 01-sql/_practice/01-social-graph-suggestions
./scripts/forge-load-practice.sh 01-sql/_practice/02-feed-candidate-debugging
./scripts/forge-test-practice.sh 01-sql/_practice/02-feed-candidate-debugging
./scripts/forge-reset-practice.sh
```

Chapter mode teaches the concept in sequence. Practice mode asks you to load a scenario, inspect named rows, break a query deliberately, read the proof failure, and reset quickly.

## Mastery Modes

After practice mode, use the SQL mastery layer:

```bash
./scripts/forge-list-gauntlet.sh
./scripts/forge-test-all-gauntlets.sh
./scripts/forge-list-takehomes.sh
./scripts/forge-test-all-takehomes.sh
./scripts/forge-list-interview-drills.sh
./scripts/forge-list-self-assessment.sh
./scripts/forge-verify-sql-mastery.sh
```

Gauntlets repair realistic broken queries. Mini take-homes feel like small backend SQL assessments. Interview drills train out-loud explanation. Self-assessment maps weak spots and decides whether to stay in SQL or move toward PostgreSQL-specific study.

## A 30-Minute Chapter Pass

Read the README, inspect `00-dataset.story.md`, run `./scripts/forge-inspect.sh <chapter>` to see the reading order, run `./scripts/forge-test.sh <chapter>`, then inspect the named rows and views in Adminer or DbGate. Finish by reading the common mistakes and one break/fix task.

## A 2-Hour Chapter Pass

Read every solution file slowly, rewrite the main query by hand, run the proof, break one important predicate or constraint, watch the proof fail, restore it, then do the stretch task.

## Do Not Skim Horizontally

Do not read all chapter names and move on. The path is vertical: relationships unlock graph queries, graph queries unlock feed candidates, feed candidates unlock ranking inputs, cursors unlock stable feeds, recursive CTEs unlock comments, and swipes unlock matching candidates.

## What Comes Next

Later paths can cover PostgreSQL-specific behavior, database optimisation, ranking/matching systems, and backend reliability patterns. They are intentionally not part of this first SQL foundation.

## PostgreSQL Path

The second path is **02-postgres**. It keeps the SQL workshop intact and adds PostgreSQL-specific backend features: types, constraints, upserts, JSONB, generated columns, views, functions, triggers, RLS, advisory locks, notifications, and schema hygiene.

```bash
./scripts/forge-list-postgres.sh
./scripts/forge-test-all-postgres.sh
./scripts/forge-verify-postgres.sh
```
