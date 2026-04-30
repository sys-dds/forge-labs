# Challenge Format

A practice pack is a complete local SQL exercise. It should load into an empty `public` schema, expose named rows that can be inspected in Adminer or DbGate, and prove the expected behavior with SQL assertions.

## Required Files

- `README.md` introduces the exercise and the command flow.
- `challenge.manifest` gives scripts a stable summary.
- `00-scenario.md` names the product moment and the backend question.
- `01-schema.sql` creates only the tables, constraints, and helper objects needed by the pack.
- `02-seed.sql` inserts teaching rows with stable ids or handles.
- `03-starting-point.sql` loads runnable starter objects for inspection.
- `04-solution.sql` creates the expected final views or SELECT-ready objects.
- `05-proof.tests.sql` fails loudly when behavior regresses.
- `06-expected-results.md` records exact rows and why they appear.
- `07-break-fix-drills.md` names intentional mistakes and the failure they should cause.
- `08-interview-explanation.md` gives the backend explanation target in plain language.

## Runtime Contract

`forge-load-practice.sh` runs:

```text
reset database
01-schema.sql
02-seed.sql
03-starting-point.sql
```

`forge-test-practice.sh` runs:

```text
reset database
01-schema.sql
02-seed.sql
03-starting-point.sql
04-solution.sql
05-proof.tests.sql
```

Proof files should use exact assertions, not loose existence checks. A good proof says which user, post, candidate, or cursor row is wrong and raises an exception when the result differs.

## Dataset Standard

Use named rows that teach a specific rule. A row is worth keeping only if it supports a positive case, a negative case, an edge case, a proof assertion, or a break/fix drill.
