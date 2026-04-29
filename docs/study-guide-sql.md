# SQL Study Guide

Do one chapter vertically. The workshop is designed so each folder changes how you think about backend data.

## 30-Minute Pass

1. Read the chapter README.
2. Read the concept explainer until you can say the backend pattern out loud.
3. Run `./scripts/forge-test.sh <chapter>`.
4. Read the main solution file named in the SQL README.
5. Read the common mistakes.

## 2-Hour Pass

1. Start the stack with `./scripts/forge-up.sh sql`.
2. Load one chapter with `./scripts/forge-load.sh <chapter>`.
3. Inspect tables and views in Adminer or DbGate.
4. Copy the main query into `./scripts/forge-shell.sh postgres` and rewrite one predicate.
5. Run `./scripts/forge-test.sh <chapter>`.
6. Break one proof intentionally, then repair it.
7. Complete the stretch task and write a 60-second interview explanation.

## What To Watch For

Look for the invariant the database protects, the rows a query is allowed to return, and the exclusion predicates that make a backend feature safe.
