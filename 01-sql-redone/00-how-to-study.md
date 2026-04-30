# How To Study A Clinic

Use the same loop every time:

1. Read `00-scenario.md` and name the product rule in plain English.
2. Inspect `00-design.md` when present, then read `01-schema.sql` and `02-seed.sql`; write down the rows that should survive.
3. Run `./scripts/forge-load-sql-redone.sh <clinic>` to load the broken state.
4. Run `./scripts/forge-test-sql-redone.sh <clinic>` and watch the broken proof fail before the script resets and proves the solution.
5. Read `06-debugging-notes.md` and match every claim to a row in the seed file.
6. Read `04-solution.sql`; identify the smallest predicate, constraint, or aggregation change that fixed the failure.
7. Rerun the proof.
8. Do the drills in `07-break-fix-drills.md`; each drill is tied to a row that should move or stay.
9. Practice `08-interview-explanation.md` out loud without saying generic phrases.

The point is not to memorize SQL syntax. The point is to learn how backend bugs show up as rows that should have been rejected, rows that disappeared, or counts that cannot be true.

Clinics 01-05 teach the core mechanics: constraints, joins, aggregation grain, pagination, and matching exclusions. Clinics 06-10 use those mechanics in endpoint/query scenarios: public profile projection, social suggestions, recursive comments, analytics funnels, and a creator discovery capstone.

Attempt clinic 10 after clinics 01-09. It expects you to recognize projection boundaries from clinic 06, graph exclusions from clinic 07, aggregation grain from clinic 03, visibility rules from clinic 02, and stable ordering from clinic 04.

Clinics 11-15 teach common product data patterns. Study them after the endpoint clinics: they move from school relationships to social feed tables, candidate generation, ranking inputs, and timeline/notification read models.

After clinic 15, move to PostgreSQL Redone for database-specific correctness. A future feed/ranking path can later handle ranking algorithms, personalization, diversity, experiments, and evaluation.
