# Comments and Recursive Queries

## What This Chapter Teaches

A recursive CTE starts with a base row, repeatedly finds children, and carries depth/path state forward.

## Real-World Backend Scenario

Comment threads and categories are parent-child rows that need recursive expansion into trees.

## Why The Previous Chapter Matters

Pagination taught stable ordering; tree reads need stable depth/path ordering too.

## Future Concept This Unlocks

Recursive CTEs let later backend paths model comments, folders, categories, and org-like hierarchies.

## Files To Read In Order

1. `00-concept.explainer.md`: read the mental model before looking at SQL.
2. `03-recursive-thread-query.solution.sql`: start here because it is the chapter's most important implementation file.
3. The remaining numbered `.solution.sql` files: read them in numeric order and trace how each file adds one backend capability.
4. `99-chapter-proof.tests.sql`: study the assertions and identify which predicate or constraint each one protects.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md`: compare the wrong patterns to the implemented solution.
6. `98-extension-tasks.md`: make one small change after the proof is green.

## What To Look For While Reading

- Root comments have no parent.
- Direct replies are one level down.
- Recursive queries keep joining children to rows already found.
- Depth tells the UI how far to indent.
- Path gives deterministic tree order.

## Run Command

```bash
./scripts/forge-test.sh 01-sql/09-comments-and-recursive-queries
```

## Study-Mode Command

```bash
./scripts/forge-load.sh 01-sql/09-comments-and-recursive-queries
```

## Expected Proof Behavior

The proof should pass as written. If you remove the chapter's key constraint, visibility predicate, ordering key, or exclusion rule, at least one assertion should fail.
