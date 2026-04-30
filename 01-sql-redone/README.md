# SQL Redone

This path is the small studyable SQL track. It exists because `01-sql/` grew into a broad archive with chapters, drills, takehomes, and gauntlets. That archive stays intact for reference. `01-sql-redone/` is the cleaner clinic layer: one dataset, one broken implementation, one proof failure, one fix, and one concrete explanation per clinic.

Run everything:

```bash
docker compose -f infra/docker-compose/docker-compose.postgres.yml up -d
./scripts/forge-test-all-sql-redone.sh
```

Study one clinic:

```bash
./scripts/forge-inspect-sql-redone.sh 01-sql-redone/02-feed-candidates-and-joins
./scripts/forge-load-sql-redone.sh 01-sql-redone/02-feed-candidates-and-joins
./scripts/forge-test-sql-redone.sh 01-sql-redone/02-feed-candidates-and-joins
```

Adminer is available at `http://localhost:8081`; DbGate is available at `http://localhost:8082`. After `forge-load-sql-redone.sh`, inspect the tables, the broken view, and the exact rows named by the clinic notes.

Recommended order:

1. `01-modeling-constraints-relationships` shows constraints as durable business rules.
2. `02-feed-candidates-and-joins` builds feed eligibility before ranking.
3. `03-aggregation-grain-and-row-multiplication` fixes child-table multiplication.
4. `04-keyset-pagination-stable-feeds` keeps scrolling stable while new rows arrive.
5. `05-matching-candidates-and-exclusions` separates unsafe candidates from preference fit.

To break/fix intentionally, change `04-solution.sql`, rerun `05-proof.tests.sql`, and force yourself to explain the exact row that proves the bug. If the explanation does not name Ada, Ben post 102, Maya, or another concrete row from the clinic, it is probably too vague.

