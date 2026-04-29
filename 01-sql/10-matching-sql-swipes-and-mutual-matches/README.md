# Matching SQL Swipes and Mutual Matches

## What This Chapter Teaches

Swipes are directed actions. Matches and recommendations are derived from those actions plus exclusions.

## Real-World Backend Scenario

Matching begins with SQL exclusions and mutual LIKE detection before any recommendation algorithm exists.

## Why The Previous Chapter Matters

Recursive queries finished the structural SQL path; matching reuses relationships, constraints, and candidate filtering.

## Future Concept This Unlocks

Preference-fit candidates become the handoff to later matching/ranking algorithms.

## Files To Read In Order

1. `00-concept.explainer.md`: read the mental model before looking at SQL.
2. `05-basic-preference-fit-query.solution.sql`: start here because it is the chapter's most important implementation file.
3. The remaining numbered `.solution.sql` files: read them in numeric order and trace how each file adds one backend capability.
4. `99-chapter-proof.tests.sql`: study the assertions and identify which predicate or constraint each one protects.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md`: compare the wrong patterns to the implemented solution.
6. `98-extension-tasks.md`: make one small change after the proof is green.

## What To Look For While Reading

- Profiles and preferences define who can be considered.
- Swipes record one decision per target.
- A mutual match is LIKE in both directions.
- Candidate exclusion removes self, already-swiped, blocked, and inactive users.
- Preference fit adds age, city, and shared-interest filters before ranking.

## Run Command

```bash
./scripts/forge-test.sh 01-sql/10-matching-sql-swipes-and-mutual-matches
```

## Study-Mode Command

```bash
./scripts/forge-load.sh 01-sql/10-matching-sql-swipes-and-mutual-matches
```

## Expected Proof Behavior

The proof should pass as written. If you remove the chapter's key constraint, visibility predicate, ordering key, or exclusion rule, at least one assertion should fail.
