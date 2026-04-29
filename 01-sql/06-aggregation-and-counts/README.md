# Aggregation and Counts

## What This Chapter Teaches

Aggregation compresses many rows into one metric, but the WHERE/JOIN shape decides what gets counted.

## Real-World Backend Scenario

Profile pages, feeds, and ranking inputs need counts that respect hidden posts and deleted comments.

## Why The Previous Chapter Matters

Chapter 05 gathered candidate rows; this chapter turns related activity into trustworthy metrics.

## Future Concept This Unlocks

Counts and grouped metrics become ranking features in the next chapter.

## Files To Read In Order

1. `00-concept.explainer.md`: read the mental model before looking at SQL.
2. `03-count-likes-and-comments.solution.sql`: start here because it is the chapter's most important implementation file.
3. The remaining numbered `.solution.sql` files: read them in numeric order and trace how each file adds one backend capability.
4. `99-chapter-proof.tests.sql`: study the assertions and identify which predicate or constraint each one protects.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md`: compare the wrong patterns to the implemented solution.
6. `98-extension-tasks.md`: make one small change after the proof is green.

## What To Look For While Reading

- COUNT posts for profile summaries.
- Count followers by grouping on followee_id.
- Use DISTINCT when joining likes and comments together.
- Filter hidden/deleted rows before they become metrics.
- Use HAVING when the filter depends on an aggregate.

## Run Command

```bash
./scripts/forge-test.sh 01-sql/06-aggregation-and-counts
```

## Study-Mode Command

```bash
./scripts/forge-load.sh 01-sql/06-aggregation-and-counts
```

## Expected Proof Behavior

The proof should pass as written. If you remove the chapter's key constraint, visibility predicate, ordering key, or exclusion rule, at least one assertion should fail.
