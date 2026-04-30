# Profile and User Querying Dataset Story

## Scenario
A public profile endpoint is being built. The endpoint should return a profile card, not a raw table dump.

## Named Dataset Rows
- ada is public, has email, two posts, two followers, and follows one user.
- ben is public, has one post, one follower, and follows two users.
- cy is non-searchable so search must skip that row.
- diya is public with no posts so empty activity still renders.

## Why Each Important Row Exists
- Teaching row 1: ada is public, has email, two posts, two followers, and follows one user. It anchors a row that should appear in a correct result.
- Teaching row 2: ben is public, has one post, one follower, and follows two users. It anchors an exclusion or edge condition the proof can name.
- Teaching row 3: cy is non-searchable so search must skip that row. It anchors a row that should appear in a correct result.
- Teaching row 4: diya is public with no posts so empty activity still renders. It anchors an exclusion or edge condition the proof can name.

## Positive Cases
- Ada profile card returns exact counts.
- Diya can appear with zero post count.
- search returns only public matching handles.

## Negative/Exclusion Cases
- email is absent from public profile views.
- cy is excluded from public search.
- missing handle returns zero rows.

## Edge Cases
- At least one row is intentionally boring or empty so the query cannot rely on every user having every related row.
- At least one row is intentionally reachable or joinable but must still be excluded by policy.
- At least one assertion checks exact names, ids, or counts so a broad query cannot pass by accident.

## Proof Assertions
- The proof asserts that Ada profile card returns exact counts.
- The proof asserts that Diya can appear with zero post count.
- The proof asserts that search returns only public matching handles.
- The proof asserts that email is absent from public profile views.
- The proof asserts that cy is excluded from public search.
- The proof asserts that missing handle returns zero rows.

## Deliberate Break/Fix
- Break: add email to public_profile_by_handle. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: join posts and follows in one aggregate without isolation. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: remove searchable filter from profile search. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
