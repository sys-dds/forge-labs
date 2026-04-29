# Aggregation and Counts Dataset Story

## Scenario
A profile/feed service needs counts for cards and ranking inputs. The numbers become product facts users trust.

## Named Dataset Rows
- ada has two visible posts and one hidden post.
- ben has one visible post.
- cy has no posts.
- diya has one hidden-style post.
- Ada post A1 has two likes, two visible comments, and one deleted comment.
- Ben and Cy follow Ada.

## Why Each Important Row Exists
- Teaching row 1: ada has two visible posts and one hidden post. It anchors a row that should appear in a correct result.
- Teaching row 2: ben has one visible post. It anchors an exclusion or edge condition the proof can name.
- Teaching row 3: cy has no posts. It anchors a row that should appear in a correct result.
- Teaching row 4: diya has one hidden-style post. It anchors an exclusion or edge condition the proof can name.
- Teaching row 5: Ada post A1 has two likes, two visible comments, and one deleted comment. It anchors a row that should appear in a correct result.
- Teaching row 6: Ben and Cy follow Ada. It anchors an exclusion or edge condition the proof can name.

## Positive Cases
- Ada visible post count is two.
- A1 visible comment count is two.
- Ben has three likes on one post.
- HAVING returns authors above threshold.

## Negative/Exclusion Cases
- hidden posts are excluded.
- deleted comments are excluded.
- direct joined count is larger than distinct count.

## Edge Cases
- At least one row is intentionally boring or empty so the query cannot rely on every user having every related row.
- At least one row is intentionally reachable or joinable but must still be excluded by policy.
- At least one assertion checks exact names, ids, or counts so a broad query cannot pass by accident.

## Proof Assertions
- The proof asserts that Ada visible post count is two.
- The proof asserts that A1 visible comment count is two.
- The proof asserts that Ben has three likes on one post.
- The proof asserts that HAVING returns authors above threshold.
- The proof asserts that hidden posts are excluded.
- The proof asserts that deleted comments are excluded.
- The proof asserts that direct joined count is larger than distinct count.

## Deliberate Break/Fix
- Break: remove hidden filter. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: count comments with deleted rows included. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: replace HAVING with WHERE on an aggregate. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
