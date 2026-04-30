# How To Study A Clinic

Use the same loop every time:

1. Read `00-scenario.md` and name the product rule in plain English.
2. Inspect `01-schema.sql` and `02-seed.sql`; write down the rows that should survive.
3. Run `./scripts/forge-load-sql-redone.sh <clinic>` to load the broken state.
4. Run `./scripts/forge-test-sql-redone.sh <clinic>` and watch the broken proof fail before the script resets and proves the solution.
5. Read `06-debugging-notes.md` and match every claim to a row in the seed file.
6. Read `04-solution.sql`; identify the smallest predicate, constraint, or aggregation change that fixed the failure.
7. Rerun the proof.
8. Do the drills in `07-break-fix-drills.md`; each drill is tied to a row that should move or stay.
9. Practice `08-interview-explanation.md` out loud without saying generic phrases.

The point is not to memorize SQL syntax. The point is to learn how backend bugs show up as rows that should have been rejected, rows that disappeared, or counts that cannot be true.

