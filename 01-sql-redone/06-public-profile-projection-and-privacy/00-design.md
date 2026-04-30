# Design

## What this clinic teaches

Query shape is an API boundary: Ben's public card should expose display fields and isolated counts, not Ben's private email or raw joined rows.

## Named rows and why each exists

- Ada is the viewer for Ada-safe search.
- Ben has `ben-private@example.test`, two visible posts, one hidden post, two followers, and one following row.
- Cy has `is_searchable = false` to prove private profiles are filtered.
- Diya is searchable with zero posts to prove missing activity is not an invalid profile.
- Noor is searchable but blocked by Ada to prove viewer-specific exclusions.
- Maya follows Ben and interacts with Ben posts so count joins can multiply.

## Broken query bug

The broken `ben_public_profile_card` includes email and counts a direct posts/followers join. The broken `ada_safe_profile_search` returns Cy, Noor, and Ada.

## Exact wrong result from the broken query

Ben's card exposes `ben-private@example.test`, reports `visible_post_count = 6`, and reports `follower_count = 6`. Ada-safe search includes `ada`, `ben`, `cy`, `diya`, and `noor`.

## Correct result from the solution

Ben's card exposes only handle, display_name, bio, visible_post_count, follower_count, and following_count with counts 2, 2, and 1. Ada-safe search returns only `ben` and `diya`.

## Proof assertions

The proof checks no email column, exact Ben counts, hidden post exclusion, Cy exclusion, Noor exclusion, Ada exclusion, and Diya inclusion.

## What the learner should notice

Counts must be isolated from each other, privacy fields must be left out of the projection, and search filters depend on the viewer.

## Interview explanation target

Explain table shape versus API shape, private field exclusion, count isolation, viewer-specific search filters, and why Diya's zero posts still produce a valid profile result.

