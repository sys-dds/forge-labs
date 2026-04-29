# Pagination and Cursors Dataset Story

## Scenario
Ada scrolls a feed while new posts are being created above the rows she already saw.

## Named Dataset Rows
- six posts exist before scrolling.
- two posts share the exact same created_at.
- a new post appears before offset page two.
- ids disambiguate timestamp ties.
- cursor page one returns a documented boundary.

## Why Each Important Row Exists
- Row group 1: six posts exist before scrolling. This row is present so the lesson has a concrete case for a positive query result rather than abstract prose.
- Row group 2: two posts share the exact same created_at. This row is present so the lesson has a concrete case for an exclusion or edge condition rather than abstract prose.
- Row group 3: a new post appears before offset page two. This row is present so the lesson has a concrete case for a positive query result rather than abstract prose.
- Row group 4: ids disambiguate timestamp ties. This row is present so the lesson has a concrete case for an exclusion or edge condition rather than abstract prose.
- Row group 5: cursor page one returns a documented boundary. This row is present so the lesson has a concrete case for a positive query result rather than abstract prose.

## Positive Cases
- keyset page one and page two return exact ids.
- timestamp ties order by id.
- cursor contains created_at and id.

## Negative/Exclusion Cases
- offset page two differs after insert.
- created_at alone cannot identify a boundary.
- DESC comparison must move older than the boundary.

## Edge Cases
- At least one row is intentionally boring or empty so the query cannot rely on every user having every related row.
- At least one row is intentionally reachable or joinable but must still be excluded by policy.
- At least one assertion checks exact names, ids, or counts so a broad query cannot pass by accident.

## Proof Assertions
- The proof asserts that keyset page one and page two return exact ids.
- The proof asserts that timestamp ties order by id.
- The proof asserts that cursor contains created_at and id.
- The proof asserts that offset page two differs after insert.
- The proof asserts that created_at alone cannot identify a boundary.
- The proof asserts that DESC comparison must move older than the boundary.

## Deliberate Break/Fix
- Break: remove id from ORDER BY. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: use OFFSET after inserting a new post. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: reverse the DESC comparison. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
