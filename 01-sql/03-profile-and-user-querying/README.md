# Profiles and User Querying

## What This Chapter Teaches

A backend query usually returns a deliberately shaped response, not table layout.

## Real-World Backend Scenario

A profile page should return a public card, not the raw account table with private fields.

## Why The Previous Chapter Matters

Chapter 02 protected user/profile/follow facts so this chapter can safely shape them into read models.

## Future Concept This Unlocks

Profile cards and counts become the display layer for followers, suggestions, and feeds.

## Files To Read In Order

1. `00-concept.explainer.md`: read the mental model before looking at SQL.
2. `04-query-profile-with-counts.solution.sql`: start here because it is the chapter's most important implementation file.
3. The remaining numbered `.solution.sql` files: read them in numeric order and trace how each file adds one backend capability.
4. `99-chapter-proof.tests.sql`: study the assertions and identify which predicate or constraint each one protects.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md`: compare the wrong patterns to the implemented solution.
6. `98-extension-tasks.md`: make one small change after the proof is green.

## What To Look For While Reading

- Keep email in the account row and out of public views.
- Join user and profile only for fields the public API needs.
- Use independent count subqueries so post/follow metrics do not multiply each other.
- Search returns a small card shape, not every profile column.

## Run Command

```bash
./scripts/forge-test.sh 01-sql/03-profile-and-user-querying
```

## Study-Mode Command

```bash
./scripts/forge-load.sh 01-sql/03-profile-and-user-querying
```

## Expected Proof Behavior

The proof should pass as written. If you remove the chapter's key constraint, visibility predicate, ordering key, or exclusion rule, at least one assertion should fail.
