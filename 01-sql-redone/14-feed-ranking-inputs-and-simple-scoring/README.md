# Feed Ranking Inputs And Simple Scoring

Backend scenario: Ada already has eligible feed candidates. SQL prepares readable ranking features and a simple score; it does not teach ML.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/14-feed-ranking-inputs-and-simple-scoring
```

## Rows To Inspect

- Ben 101 is recent, followed-author, 2 likes, and 3 comments.
- Ben 102 is older, followed-author, 5 likes, and 1 comment.
- Maya 301 is recent, shared-group, 1 like, and 2 comments.
- Lina 601 is recent, liked-by-following, 4 likes, and 0 comments.
- Lina 602 is older, reposted-by-following, 1 like, and 1 comment.

