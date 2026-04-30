# Feed Candidate Generation

Backend scenario: Ada opens home feed. The backend collects eligible candidate posts from followed authors, shared groups, liked-by-following, and reposted-by-following sources before ranking.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/13-feed-candidate-generation
```

## Rows To Inspect

- Ben post 101 is a followed-author candidate.
- Maya post 301 is a shared Backend Club candidate.
- Lina posts 601 and 602 are surfaced through Diya's like and repost.
- Cy post 201 is muted; Noor post 701 is blocked even though Diya liked it.
- Omar post 801 and Theo post 901 are public but have no candidate path.

