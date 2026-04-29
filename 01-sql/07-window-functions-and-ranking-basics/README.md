# Window Functions and Ranking Basics

## What This Chapter Teaches

Window functions add per-row context without collapsing rows the way GROUP BY does.

## Real-World Backend Scenario

Ranking systems need ordered candidate rows and raw signals such as latest post, engagement rank, and running totals.

## Why The Previous Chapter Matters

Chapter 06 produced metrics; window functions keep row detail while adding position and history.

## Future Concept This Unlocks

Ranking-shaped SQL output prepares the later ranking/matching path without implementing a scoring algorithm yet.

## Files To Read In Order

1. `00-concept.explainer.md`: read the mental model before looking at SQL.
2. `05-feed-ranking-inputs.solution.sql`: start here because it is the chapter's most important implementation file.
3. The remaining numbered `.solution.sql` files: read them in numeric order and trace how each file adds one backend capability.
4. `99-chapter-proof.tests.sql`: study the assertions and identify which predicate or constraint each one protects.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md`: compare the wrong patterns to the implemented solution.
6. `98-extension-tasks.md`: make one small change after the proof is green.

## What To Look For While Reading

- ROW_NUMBER selects one latest row per author.
- RANK gives tied posts the same rank and leaves gaps.
- DENSE_RANK gives tied authors the same rank without gaps.
- Running totals accumulate metrics within each author partition.
- Feed ranking inputs expose columns, not final recommendations.

## Run Command

```bash
./scripts/forge-test.sh 01-sql/07-window-functions-and-ranking-basics
```

## Study-Mode Command

```bash
./scripts/forge-load.sh 01-sql/07-window-functions-and-ranking-basics
```

## Expected Proof Behavior

The proof should pass as written. If you remove the chapter's key constraint, visibility predicate, ordering key, or exclusion rule, at least one assertion should fail.
