# Matching SQL, Swipes, and Mutual Matches Dataset Story

## Scenario
Ada opens matching candidates. SQL removes unsafe and impossible candidates before any ranking score is computed.

## Named Dataset Rows
- ada is active age 30 in Glasgow with sql hiking coffee interests.
- ben is active, overlaps with Ada, and has mutual LIKE.
- cy is active but Ada passed Cy.
- diya is active but blocked by Ada.
- noor is inactive.
- maya is active, unswiped, Glasgow, and overlaps two interests.
- omar is active and unswiped but outside preference fit.

## Why Each Important Row Exists
- Row group 1: ada is active age 30 in Glasgow with sql hiking coffee interests. This row is present so the lesson has a concrete case for a positive query result rather than abstract prose.
- Row group 2: ben is active, overlaps with Ada, and has mutual LIKE. This row is present so the lesson has a concrete case for an exclusion or edge condition rather than abstract prose.
- Row group 3: cy is active but Ada passed Cy. This row is present so the lesson has a concrete case for a positive query result rather than abstract prose.
- Row group 4: diya is active but blocked by Ada. This row is present so the lesson has a concrete case for an exclusion or edge condition rather than abstract prose.
- Row group 5: noor is inactive. This row is present so the lesson has a concrete case for a positive query result rather than abstract prose.
- Row group 6: maya is active, unswiped, Glasgow, and overlaps two interests. This row is present so the lesson has a concrete case for an exclusion or edge condition rather than abstract prose.
- Row group 7: omar is active and unswiped but outside preference fit. This row is present so the lesson has a concrete case for a positive query result rather than abstract prose.

## Positive Cases
- mutual match is Ada-Ben only.
- raw candidates are Maya and Omar.
- preference-fit candidate is Maya only.
- Maya shares two interests.

## Negative/Exclusion Cases
- duplicate and self swipes fail.
- Cy PASS does not match.
- Diya blocked excluded.
- Noor inactive excluded.
- Ben/Cy already swiped excluded.

## Edge Cases
- At least one row is intentionally boring or empty so the query cannot rely on every user having every related row.
- At least one row is intentionally reachable or joinable but must still be excluded by policy.
- At least one assertion checks exact names, ids, or counts so a broad query cannot pass by accident.

## Proof Assertions
- The proof asserts that mutual match is Ada-Ben only.
- The proof asserts that raw candidates are Maya and Omar.
- The proof asserts that preference-fit candidate is Maya only.
- The proof asserts that Maya shares two interests.
- The proof asserts that duplicate and self swipes fail.
- The proof asserts that Cy PASS does not match.
- The proof asserts that Diya blocked excluded.
- The proof asserts that Noor inactive excluded.
- The proof asserts that Ben/Cy already swiped excluded.

## Deliberate Break/Fix
- Break: treat any reciprocal swipe as match. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: remove already-swiped exclusion. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: mix preference fit into raw safety exclusions. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
