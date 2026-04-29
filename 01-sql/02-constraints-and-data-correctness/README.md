# Constraints and Data Correctness

## What This Chapter Teaches

Constraints are the database final guard when application checks are late, missing, or racing.

## Real-World Backend Scenario

A follow endpoint can receive duplicate or self-follow requests, especially when clients retry or two requests race.

## Why The Previous Chapter Matters

Chapter 01 named the tables and relationship shapes; this chapter makes those shapes enforceable.

## Future Concept This Unlocks

Safe follows become trustworthy input for profile counts, followers lists, and social graph traversal.

## Files To Read In Order

1. `00-concept.explainer.md`: read the mental model before looking at SQL.
2. `05-follow-table-correctness.solution.sql`: start here because it is the chapter's most important implementation file.
3. The remaining numbered `.solution.sql` files: read them in numeric order and trace how each file adds one backend capability.
4. `99-chapter-proof.tests.sql`: study the assertions and identify which predicate or constraint each one protects.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md`: compare the wrong patterns to the implemented solution.
6. `98-extension-tasks.md`: make one small change after the proof is green.

## What To Look For While Reading

- NOT NULL marks facts the backend must always know.
- UNIQUE protects lookup identities such as handles.
- FOREIGN KEY keeps relationships attached to real users.
- CHECK rejects local nonsense such as self-follow.
- A composite primary key says the follow pair is the identity.

## Run Command

```bash
./scripts/forge-test.sh 01-sql/02-constraints-and-data-correctness
```

## Study-Mode Command

```bash
./scripts/forge-load.sh 01-sql/02-constraints-and-data-correctness
```

## Expected Proof Behavior

The proof should pass as written. If you remove the chapter's key constraint, visibility predicate, ordering key, or exclusion rule, at least one assertion should fail.
