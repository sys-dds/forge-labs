# 01 SQL

This path teaches SQL through backend-shaped examples: users, profiles, followers, feed candidates, counts, ranking inputs, cursors, comments, and matching.

## Chapter Map

01 tables and relationships
02 constraints and correctness
03 profiles and user querying
04 followers and social graph
05 joins and feed candidates
06 aggregation and counts
07 window functions and ranking basics
08 pagination and cursors
09 comments and recursive queries
10 matching SQL

## Knowledge Unlock Chain

Relationships unlock graph queries. Graph queries unlock feed candidates. Feed candidates unlock ranking. Pagination unlocks production feeds. Recursive queries unlock comments and categories. Swipes unlock matching candidates.

## Recommended Reading Order

Read each folder in order. Every chapter reuses the previous mental model and unlocks the next one.

## Commands

```bash
docker compose -f infra/docker-compose/docker-compose.postgres.yml up -d
./scripts/run-all-sql-chapters.sh
./scripts/run-sql-chapter.sh 01-sql/08-pagination-and-cursors
docker compose -f infra/docker-compose/docker-compose.postgres.yml down -v
```

## Troubleshooting

If Docker is not running, start Docker first. If a chapter fails, read the exception from `99-chapter-proof.tests.sql`; proof failures are designed to point at the concept that broke.
