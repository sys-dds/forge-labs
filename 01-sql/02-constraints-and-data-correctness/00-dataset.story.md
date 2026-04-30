# Constraints and Data Correctness Dataset Story

## Scenario
Two follow requests for Ada following Ben arrive at the same time. The application can check first, but only the database can serialize the final truth.

## Named Dataset Rows
- ada and ben have unique lower-case handles.
- ada follows ben once.
- cy and diya exist so invalid and valid relationship attempts are distinguishable.
- profiles are tied to existing users only.

## Why Each Important Row Exists
- Teaching row 1: ada and ben have unique lower-case handles. It anchors a row that should appear in a correct result.
- Teaching row 2: ada follows ben once. It anchors an exclusion or edge condition the proof can name.
- Teaching row 3: cy and diya exist so invalid and valid relationship attempts are distinguishable. It anchors a row that should appear in a correct result.
- Teaching row 4: profiles are tied to existing users only. It anchors an exclusion or edge condition the proof can name.

## Positive Cases
- Ada to Ben follow is stored exactly once.
- profiles point at real users.
- handles are nonblank and lower-case.

## Negative/Exclusion Cases
- duplicate Ada to Ben follow fails.
- Ada to Ada self-follow fails.
- follow to user 999 fails.
- profile for user 999 fails.

## Edge Cases
- At least one row is intentionally boring or empty so the query cannot rely on every user having every related row.
- At least one row is intentionally reachable or joinable but must still be excluded by policy.
- At least one assertion checks exact names, ids, or counts so a broad query cannot pass by accident.

## Proof Assertions
- The proof asserts that Ada to Ben follow is stored exactly once.
- The proof asserts that profiles point at real users.
- The proof asserts that handles are nonblank and lower-case.
- The proof asserts that duplicate Ada to Ben follow fails.
- The proof asserts that Ada to Ada self-follow fails.
- The proof asserts that follow to user 999 fails.
- The proof asserts that profile for user 999 fails.

## Deliberate Break/Fix
- Break: drop the composite primary key on follows. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: drop the self-follow CHECK. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: drop the follows foreign keys. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
