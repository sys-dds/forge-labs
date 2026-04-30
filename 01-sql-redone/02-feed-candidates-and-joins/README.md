# Feed Candidates And Joins

Backend scenario: Ada opens her feed. The service must build eligible followed-author posts before ranking, then attach like and comment counts without removing zero-comment posts.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/02-feed-candidates-and-joins
```

## Rows To Inspect

- Ben post 102 is newer than Ben post 101 and has zero comments, so it must survive optional comment joins.
- Ben post 101 has exactly 2 likes and 3 comments.
- Cy post 201 is followed but muted by Ada, so it must be removed before ranking.
- Noor post 301 is followed but blocked by Ada, so it must be removed before ranking.
- Diya post 401 is visible but Ada does not follow Diya.
- Ben post 103 is hidden and cannot enter the feed.

