# Comments and Recursive Queries Dataset Story

## Scenario
A post has nested comments, and the backend needs the whole thread with depth and stable path ordering.

## Named Dataset Rows
- post 100 has c1 root, c2 and c3 replies, c4 under c2, c5 under c4.
- post 200 has c6 and c7 to prove scope.
- categories include Electronics, Computers, Laptops, Phones, Home.

## Why Each Important Row Exists
- Teaching row 1: post 100 has c1 root, c2 and c3 replies, c4 under c2, c5 under c4. It anchors a row that should appear in a correct result.
- Teaching row 2: post 200 has c6 and c7 to prove scope. It anchors an exclusion or edge condition the proof can name.
- Teaching row 3: categories include Electronics, Computers, Laptops, Phones, Home. It anchors a row that should appear in a correct result.

## Positive Cases
- direct replies to c1 are c2 and c3.
- recursive thread order is c1,c2,c4,c5,c3.
- depths are exact.
- category tree uses same recursion pattern.

## Negative/Exclusion Cases
- post 200 comments are excluded.
- invalid parent comment fails.
- unstable path ordering is visible.

## Edge Cases
- At least one row is intentionally boring or empty so the query cannot rely on every user having every related row.
- At least one row is intentionally reachable or joinable but must still be excluded by policy.
- At least one assertion checks exact names, ids, or counts so a broad query cannot pass by accident.

## Proof Assertions
- The proof asserts that direct replies to c1 are c2 and c3.
- The proof asserts that recursive thread order is c1,c2,c4,c5,c3.
- The proof asserts that depths are exact.
- The proof asserts that category tree uses same recursion pattern.
- The proof asserts that post 200 comments are excluded.
- The proof asserts that invalid parent comment fails.
- The proof asserts that unstable path ordering is visible.

## Deliberate Break/Fix
- Break: remove post_id scope. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: remove parent foreign key. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: order only by created_at instead of path. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
