# Tables and Relationships Dataset Story

## Scenario
A tiny social product is being modeled from zero. Ada, Ben, Cy, and Diya are durable identity facts queried through profiles, posts, settings, and early follow edges.

## Named Dataset Rows
- ada has a profile, optional settings, two posts, and preview follows to ben and cy.
- ben has a profile, one post, and intentionally no settings.
- cy has a profile and exists as a second follow target.
- diya has a profile and proves the model supports users before they post or receive settings.

## Why Each Important Row Exists
- Row group 1: ada has a profile, optional settings, two posts, and preview follows to ben and cy. This row is present so the lesson has a concrete case for a positive query result rather than abstract prose.
- Row group 2: ben has a profile, one post, and intentionally no settings. This row is present so the lesson has a concrete case for an exclusion or edge condition rather than abstract prose.
- Row group 3: cy has a profile and exists as a second follow target. This row is present so the lesson has a concrete case for a positive query result rather than abstract prose.
- Row group 4: diya has a profile and proves the model supports users before they post or receive settings. This row is present so the lesson has a concrete case for an exclusion or edge condition rather than abstract prose.

## Positive Cases
- Ada can own multiple posts without duplicating Ada herself.
- Ben can exist without a settings row.
- Ada can follow Ben and Cy as two separate relationship facts.

## Negative/Exclusion Cases
- duplicate profile for Ada is rejected.
- post with missing author is rejected.
- duplicate Ada to Ben preview follow is rejected.

## Edge Cases
- At least one row is intentionally boring or empty so the query cannot rely on every user having every related row.
- At least one row is intentionally reachable or joinable but must still be excluded by policy.
- At least one assertion checks exact names, ids, or counts so a broad query cannot pass by accident.

## Proof Assertions
- The proof asserts that Ada can own multiple posts without duplicating Ada herself.
- The proof asserts that Ben can exist without a settings row.
- The proof asserts that Ada can follow Ben and Cy as two separate relationship facts.
- The proof asserts that duplicate profile for Ada is rejected.
- The proof asserts that post with missing author is rejected.
- The proof asserts that duplicate Ada to Ben preview follow is rejected.

## Deliberate Break/Fix
- Break: remove the unique protection on user_profiles.user_id. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: remove the posts.author_id foreign key. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: replace the composite follows_preview key with only a surrogate id. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
