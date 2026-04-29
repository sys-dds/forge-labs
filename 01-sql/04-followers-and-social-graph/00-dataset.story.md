# Followers and Social Graph Dataset Story

## Scenario
Ada opens People you may know. The graph can reach several users, but reachability is not eligibility.

## Named Dataset Rows
- ada follows ben and cy.
- ben follows ada and diya.
- cy follows diya and noor.
- diya and noor follow ada.
- theo is disconnected.
- ada blocks noor and mutes cy.

## Why Each Important Row Exists
- Row group 1: ada follows ben and cy. This row is present so the lesson has a concrete case for a positive query result rather than abstract prose.
- Row group 2: ben follows ada and diya. This row is present so the lesson has a concrete case for an exclusion or edge condition rather than abstract prose.
- Row group 3: cy follows diya and noor. This row is present so the lesson has a concrete case for a positive query result rather than abstract prose.
- Row group 4: diya and noor follow ada. This row is present so the lesson has a concrete case for an exclusion or edge condition rather than abstract prose.
- Row group 5: theo is disconnected. This row is present so the lesson has a concrete case for a positive query result rather than abstract prose.
- Row group 6: ada blocks noor and mutes cy. This row is present so the lesson has a concrete case for an exclusion or edge condition rather than abstract prose.

## Positive Cases
- Ada following is ben and cy.
- Ada followers are ben, diya, and noor.
- Ada mutual follows are ben.
- Ada suggestions are diya only.

## Negative/Exclusion Cases
- noor is reachable but blocked.
- cy remains followed but hidden from feed-style output.
- theo never appears accidentally.

## Edge Cases
- At least one row is intentionally boring or empty so the query cannot rely on every user having every related row.
- At least one row is intentionally reachable or joinable but must still be excluded by policy.
- At least one assertion checks exact names, ids, or counts so a broad query cannot pass by accident.

## Proof Assertions
- The proof asserts that Ada following is ben and cy.
- The proof asserts that Ada followers are ben, diya, and noor.
- The proof asserts that Ada mutual follows are ben.
- The proof asserts that Ada suggestions are diya only.
- The proof asserts that noor is reachable but blocked.
- The proof asserts that cy remains followed but hidden from feed-style output.
- The proof asserts that theo never appears accidentally.

## Deliberate Break/Fix
- Break: reverse follower_id and followee_id in followers query. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: remove already-followed exclusion. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: remove blocked exclusion from suggestions. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
