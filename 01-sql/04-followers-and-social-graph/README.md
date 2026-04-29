# Followers and Social Graph

## What This Chapter Teaches

A follow is a directed edge: follower_id points from the actor, followee_id points to the target.

## Real-World Backend Scenario

The same directed follow edge answers followers, following, mutual follows, and second-degree suggestions.

## Why The Previous Chapter Matters

Profile reads are useful, but social products become interesting when user-to-user edges are queried in both directions.

## Future Concept This Unlocks

Graph traversal provides the viewer-specific author set used by feed candidate generation.

## Files To Read In Order

1. `00-concept.explainer.md`: read the mental model before looking at SQL.
2. `05-follow-suggestions-query.solution.sql`: start here because it is the chapter's most important implementation file.
3. The remaining numbered `.solution.sql` files: read them in numeric order and trace how each file adds one backend capability.
4. `99-chapter-proof.tests.sql`: study the assertions and identify which predicate or constraint each one protects.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md`: compare the wrong patterns to the implemented solution.
6. `98-extension-tasks.md`: make one small change after the proof is green.

## What To Look For While Reading

- Followers of Ada are rows where Ada is followee_id.
- Following for Ada are rows where Ada is follower_id.
- Mutual follows require two opposite edges.
- Suggestions walk from Ada to people she follows, then to people they follow.
- Blocks remove unsafe users; mutes suppress feed candidates without deleting follows.

## Run Command

```bash
./scripts/forge-test.sh 01-sql/04-followers-and-social-graph
```

## Study-Mode Command

```bash
./scripts/forge-load.sh 01-sql/04-followers-and-social-graph
```

## Expected Proof Behavior

The proof should pass as written. If you remove the chapter's key constraint, visibility predicate, ordering key, or exclusion rule, at least one assertion should fail.
