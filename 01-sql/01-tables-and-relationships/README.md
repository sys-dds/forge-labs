# Tables and Relationships

## What This Chapter Teaches

Tables model backend facts; keys and foreign keys describe which facts are allowed to depend on other facts.

## Real-World Backend Scenario

A social product has account rows, public profile rows, authored posts, optional settings, and the first preview of follow edges.

## Why The Previous Chapter Matters

This is the starting point: it teaches users as durable facts and relationships as explicit database structure.

## Future Concept This Unlocks

Once users can be related to profiles, posts, settings, and other users, the next chapter can protect those relationships with constraints.

## Files To Read In Order

1. `00-concept.explainer.md`: read the mental model before looking at SQL.
2. `02-one-to-one-profile.solution.sql`: start here because it is the chapter's most important implementation file.
3. The remaining numbered `.solution.sql` files: read them in numeric order and trace how each file adds one backend capability.
4. `99-chapter-proof.tests.sql`: study the assertions and identify which predicate or constraint each one protects.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md`: compare the wrong patterns to the implemented solution.
6. `98-extension-tasks.md`: make one small change after the proof is green.

## What To Look For While Reading

- A user row is the node every other feature points at.
- A profile row is one-to-one because one account owns one public profile.
- Posts are one-to-many because one author can publish many rows.
- Settings are optional because a user can exist before choosing preferences.
- The follow preview shows that relationships between users are rows too.

## Run Command

```bash
./scripts/forge-test.sh 01-sql/01-tables-and-relationships
```

## Study-Mode Command

```bash
./scripts/forge-load.sh 01-sql/01-tables-and-relationships
```

## Expected Proof Behavior

The proof should pass as written. If you remove the chapter's key constraint, visibility predicate, ordering key, or exclusion rule, at least one assertion should fail.
