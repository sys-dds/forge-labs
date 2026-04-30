# Feed Candidate Debugging

Ada opens her feed. This pack builds the candidate set before ranking. Ranking should never be asked to repair unsafe candidates, muted authors, blocked authors, or row multiplication created by careless joins.

Run:

```bash
./scripts/forge-load-practice.sh 01-sql/_practice/02-feed-candidate-debugging
./scripts/forge-test-practice.sh 01-sql/_practice/02-feed-candidate-debugging
```

Expected final view: `ada_feed_candidates`
