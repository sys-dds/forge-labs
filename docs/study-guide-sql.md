# SQL Study Guide

Do one chapter vertically. The workshop is designed so each folder changes how you think about backend data.

## 30-Minute Pass

1. Read the chapter README.
2. Read `00-dataset.story.md` and identify the positive, negative, and edge rows.
3. Run `./scripts/forge-inspect.sh <chapter>` to see the reading order and proof file.
4. Read the concept explainer until you can say the backend pattern out loud.
5. Run `./scripts/forge-test.sh <chapter>`.
6. Read the main solution file named in the SQL README.
7. Read the common mistakes.

## 2-Hour Pass

1. Start the stack with `./scripts/forge-up.sh sql`.
2. Load one chapter with `./scripts/forge-load.sh <chapter>`.
3. Run `./scripts/forge-inspect.sh <chapter>` and follow the listed reading order.
4. Inspect tables and views in Adminer or DbGate.
5. Copy the main query into `./scripts/forge-shell.sh postgres` and rewrite one predicate.
6. Run `./scripts/forge-test.sh <chapter>`.
7. Break one proof intentionally, then repair it.
8. Complete the stretch task and write a 60-second interview explanation.

## Practice Pass

Use this after the related chapter pass.

1. Run `./scripts/forge-list-practice.sh`.
2. Inspect one pack with `./scripts/forge-inspect-practice.sh <practice-pack>`.
3. Read `00-scenario.md`, `06-expected-results.md`, and `07-break-fix-drills.md`.
4. Load it with `./scripts/forge-load-practice.sh <practice-pack>`.
5. Inspect the named rows and starter views in Adminer or DbGate.
6. Run `./scripts/forge-test-practice.sh <practice-pack>`.
7. Break one drill in `04-solution.sql`, rerun the proof, then restore it.
8. Reset with `./scripts/forge-reset-practice.sh`.

## Mastery Pass

1. Run `./scripts/forge-test-all-gauntlets.sh` and read each broken-query failure as evidence.
2. Solve one take-home before opening `04-solution.sql`.
3. Use `./scripts/forge-list-interview-drills.sh` and answer three prompts out loud.
4. Score misses with `01-sql/_self-assessment/sql-skill-rubric.md`.
5. Run `./scripts/forge-verify-sql-mastery.sh` before deciding the SQL path is complete.

## What To Watch For

Look for the invariant the database protects, the rows a query is allowed to return, and the exclusion predicates that make a backend feature safe.
