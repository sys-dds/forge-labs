# Forge Labs

Forge Labs is a never-ending backend learning workshop for senior Java/backend fundamentals. It is intentionally not a portfolio app, not a product clone, and not a question bank. The repo exists to make fundamentals feel concrete by connecting each concept to backend work you would actually do.

The current path is **01-sql**. SQL starts the workshop because it is where backend systems discover rows, protect invariants, apply visibility rules, count behavior, paginate feeds, and prepare candidates for ranking or matching.

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
```

Then open Adminer at http://localhost:8081 or DbGate at http://localhost:8082. Connect with database `forge_labs`, user `forge_labs`, and password `forge_labs`.

## A 30-Minute Chapter Pass

Read the README, skim the concept explainer, run `./scripts/forge-test.sh <chapter>`, then inspect the main view in Adminer or DbGate. Finish by reading the common mistakes.

## A 2-Hour Chapter Pass

Read every solution file slowly, rewrite the main query by hand, run the proof, break one important predicate or constraint, watch the proof fail, restore it, then do the stretch task.

## Do Not Skim Horizontally

Do not read all chapter names and move on. The path is vertical: relationships unlock graph queries, graph queries unlock feed candidates, feed candidates unlock ranking inputs, cursors unlock stable feeds, recursive CTEs unlock comments, and swipes unlock matching candidates.

## What Comes Next

Later paths can cover PostgreSQL-specific behavior, database optimisation, Spring Data JPA, Java generics, Java concurrency, Java collections, ranking/matching systems, and backend reliability patterns. They are intentionally not part of this first SQL foundation.
