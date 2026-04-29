# Joins and Feed Candidates

## What This Chapter Teaches

Joins combine facts, but candidate generation also needs anti-joins that exclude unsafe or muted rows.

## Real-World Backend Scenario

A feed cannot be ranked until SQL gathers posts the viewer is allowed to see.

## Why The Previous Chapter Matters

Chapter 04 produced graph edges and visibility rules; this chapter joins them to posts and author cards.

## Future Concept This Unlocks

Candidate posts plus relationship metadata become raw input for metrics and ranking.

## Files To Read In Order

1. `00-concept.explainer.md`: read the mental model before looking at SQL.
2. `06-feed-candidates-from-following.solution.sql`: start here because it is the chapter's most important implementation file.
3. The remaining numbered `.solution.sql` files: read them in numeric order and trace how each file adds one backend capability.
4. `99-chapter-proof.tests.sql`: study the assertions and identify which predicate or constraint each one protects.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md`: compare the wrong patterns to the implemented solution.
6. `98-extension-tasks.md`: make one small change after the proof is green.

## What To Look For While Reading

- INNER JOIN finds posts from followed authors.
- LEFT JOIN keeps rows when optional metrics are absent.
- Self joins compare rows in the same table.
- Anti joins remove blocked or muted authors.
- Metrics joins can multiply rows, so counts need isolated aggregation.

## Run Command

```bash
./scripts/forge-test.sh 01-sql/05-joins-and-feed-candidates
```

## Study-Mode Command

```bash
./scripts/forge-load.sh 01-sql/05-joins-and-feed-candidates
```

## Expected Proof Behavior

The proof should pass as written. If you remove the chapter's key constraint, visibility predicate, ordering key, or exclusion rule, at least one assertion should fail.
