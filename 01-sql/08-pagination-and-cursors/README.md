# Pagination and Cursors

## What This Chapter Teaches

A cursor is an anchor in an ordered result set; it should use enough columns to make the order unique.

## Real-World Backend Scenario

Feeds and follower lists need stable next pages while new rows are inserted.

## Why The Previous Chapter Matters

Ranking inputs need deterministic ordering before they can be paginated safely.

## Future Concept This Unlocks

Stable keyset cursors make production feed scrolling possible.

## Files To Read In Order

1. `00-concept.explainer.md`: read the mental model before looking at SQL.
2. `03-keyset-pagination.solution.sql`: start here because it is the chapter's most important implementation file.
3. The remaining numbered `.solution.sql` files: read them in numeric order and trace how each file adds one backend capability.
4. `99-chapter-proof.tests.sql`: study the assertions and identify which predicate or constraint each one protects.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md`: compare the wrong patterns to the implemented solution.
6. `98-extension-tasks.md`: make one small change after the proof is green.

## What To Look For While Reading

- Offset pagination counts positions and can drift.
- Keyset pagination asks for rows after the last seen key.
- created_at alone is not unique, so id is the tie-breaker.
- The cursor shape returns the keys needed for the next request.

## Run Command

```bash
./scripts/forge-test.sh 01-sql/08-pagination-and-cursors
```

## Study-Mode Command

```bash
./scripts/forge-load.sh 01-sql/08-pagination-and-cursors
```

## Expected Proof Behavior

The proof should pass as written. If you remove the chapter's key constraint, visibility predicate, ordering key, or exclusion rule, at least one assertion should fail.
