# Window Functions and Ranking Inputs Dataset Story

## Scenario
The backend prepares rows for a future ranking system without pretending SQL rank labels are the algorithm.

## Named Dataset Rows
- ada has three posts with a clear latest id.
- ben has two posts.
- cy has one post.
- two posts tie on engagement.
- two authors tie on follower count.
- engagement events are ordered per author.

## Why Each Important Row Exists
- Teaching row 1: ada has three posts with a clear latest id. It anchors a row that should appear in a correct result.
- Teaching row 2: ben has two posts. It anchors an exclusion or edge condition the proof can name.
- Teaching row 3: cy has one post. It anchors a row that should appear in a correct result.
- Teaching row 4: two posts tie on engagement. It anchors an exclusion or edge condition the proof can name.
- Teaching row 5: two authors tie on follower count. It anchors a row that should appear in a correct result.
- Teaching row 6: engagement events are ordered per author. It anchors an exclusion or edge condition the proof can name.

## Positive Cases
- latest per author returns one exact post each.
- RANK leaves a gap after a tie.
- DENSE_RANK does not leave a gap.
- running total restarts per author.

## Negative/Exclusion Cases
- missing tie-breaker is nondeterministic.
- running total without partition mixes authors.
- ranking input is not a final algorithm.

## Edge Cases
- At least one row is intentionally boring or empty so the query cannot rely on every user having every related row.
- At least one row is intentionally reachable or joinable but must still be excluded by policy.
- At least one assertion checks exact names, ids, or counts so a broad query cannot pass by accident.

## Proof Assertions
- The proof asserts that latest per author returns one exact post each.
- The proof asserts that RANK leaves a gap after a tie.
- The proof asserts that DENSE_RANK does not leave a gap.
- The proof asserts that running total restarts per author.
- The proof asserts that missing tie-breaker is nondeterministic.
- The proof asserts that running total without partition mixes authors.
- The proof asserts that ranking input is not a final algorithm.

## Deliberate Break/Fix
- Break: remove id tie-breaker. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: remove PARTITION BY. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: filter ROW_NUMBER in the same SELECT layer. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
