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
6. `06-public-profile-projection-and-privacy` shapes public profile output and keeps private fields out.
7. `07-social-graph-suggestions-and-mutuals` separates followers, following, mutuals, and safe suggestions.
8. `08-recursive-comment-threads` returns a scoped comment subtree with depth and stable order.
9. `09-analytics-funnel-and-daily-metrics` counts signup-user funnel metrics instead of raw event rows.
10. `10-sql-endpoint-capstone` combines projection, graph exclusions, aggregation, visible signals, and stable cursors.

Clinics 01-05 teach core mechanics: constraints, joins, aggregation grain, pagination, and matching exclusions. Clinics 06-10 turn those mechanics into endpoint-shaped backend scenarios: public projections, graph suggestions, recursive threads, analytics dashboards, and a creator discovery capstone.

To break/fix intentionally, change `04-solution.sql`, rerun `05-proof.tests.sql`, and force yourself to explain the exact row that proves the bug. If the explanation does not name Ada, Ben post 102, Maya, or another concrete row from the clinic, it is probably too vague.
