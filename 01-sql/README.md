# 01 SQL

This path teaches SQL as backend behavior: modeling users and profiles, protecting relationships, reading public profile cards, traversing social graphs, preparing feed candidates, counting metrics, shaping ranking inputs, paginating stable feeds, reading trees, and filtering matching candidates.

## Chapter Map

| Chapter | Main concept | Backend pattern | Unlocks next | Start here |
| --- | --- | --- | --- | --- |
| 01 | Tables and relationships | users, profiles, posts, settings, follow preview | graph-shaped data | `02-one-to-one-profile.solution.sql` |
| 02 | Constraints and correctness | database as final guard for follows | safe relationship writes | `05-follow-table-correctness.solution.sql` |
| 03 | Profiles and user querying | public profile card instead of table dump | social graph screens | `04-query-profile-with-counts.solution.sql` |
| 04 | Followers and social graph | directed follows, mutuals, suggestions, blocks, mutes | feed candidates | `05-follow-suggestions-query.solution.sql` |
| 05 | Joins and feed candidates | visible posts from followed authors | ranking inputs | `06-feed-candidates-from-following.solution.sql` |
| 06 | Aggregation and counts | engagement and author metrics | score features | `03-count-likes-and-comments.solution.sql` |
| 07 | Window functions | latest per author, ranks, running totals | ordered ranking input rows | `05-feed-ranking-inputs.solution.sql` |
| 08 | Pagination and cursors | keyset pages with stable tie-breakers | production feed scrolling | `03-keyset-pagination.solution.sql` |
| 09 | Recursive queries | comments and category trees | hierarchical reads | `03-recursive-thread-query.solution.sql` |
| 10 | Matching SQL | swipes, mutual likes, exclusions, preference fit | matching recommendations | `05-basic-preference-fit-query.solution.sql` |

## Commands

```bash
./scripts/forge-up.sh sql
./scripts/forge-list.sh
./scripts/forge-test.sh 01-sql/10-matching-sql-swipes-and-mutual-matches
./scripts/forge-load.sh 01-sql/04-followers-and-social-graph
./scripts/forge-shell.sh postgres
./scripts/forge-down.sh
```

## Troubleshooting

If a chapter fails, read the exception in `99-chapter-proof.tests.sql`. Proof failures are not noise: they usually identify a missing predicate, broken constraint, or inflated count. If Adminer or DbGate is not reachable, run `./scripts/forge-status.sh` and `./scripts/forge-logs.sh`.
