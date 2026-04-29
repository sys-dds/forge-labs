# 03 Profile and User Querying

## Scenario
A public profile endpoint is being built. The endpoint should return a profile card, not a raw table dump.

## What This Chapter Teaches
This chapter teaches safe projections, public/private field separation, count subqueries, profile card shape, and public search results. The goal is not to memorize syntax. The goal is to see how a backend idea becomes rows, predicates, constraints, and proof assertions.

## Why This Matters In Real Backends
Backend queries often define API boundaries. Returning storage shape leaks email and couples clients to internal tables. The query is a response contract. Select only public facts the caller may learn.

## Named Dataset Story
- ada is public, has email, two posts, two followers, and follows one user.
- ben is public, has one post, one follower, and follows two users.
- cy is non-searchable so search must skip that row.
- diya is public with no posts so empty activity still renders.

## Files To Read In Order
1. `00-dataset.story.md` to understand why every named row exists.
2. `00-concept.explainer.md` for the backend mental model.
3. The numbered `.solution.sql` files in order; inspect the comments before running each query.
4. `99-chapter-proof.tests.sql` to see which claims are enforced mechanically.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md` after the correct version is clear.
6. `98-extension-tasks.md` when you are ready to break and repair the lesson.

## What To Inspect In Adminer Or DbGate
Load the chapter with `./scripts/forge-load.sh 01-sql/03-profile-and-user-querying`. Start by opening the base tables and finding the named rows. Then open the views created by the solution files and compare them with the positive and negative cases in the dataset story. Do not begin with the final query; begin with the rows that make the query necessary.

## What The Proof Tests Prove
- Positive: Ada profile card returns exact counts.
- Positive: Diya can appear with zero post count.
- Positive: search returns only public matching handles.
- Negative/exclusion: email is absent from public profile views.
- Negative/exclusion: cy is excluded from public search.
- Negative/exclusion: missing handle returns zero rows.

## What To Deliberately Break
- add email to public_profile_by_handle. Rerun `./scripts/forge-test.sh 01-sql/03-profile-and-user-querying` and read the failure before restoring the predicate or constraint.
- join posts and follows in one aggregate without isolation. Rerun `./scripts/forge-test.sh 01-sql/03-profile-and-user-querying` and read the failure before restoring the predicate or constraint.
- remove searchable filter from profile search. Rerun `./scripts/forge-test.sh 01-sql/03-profile-and-user-querying` and read the failure before restoring the predicate or constraint.

## Interview Explanation Target
A senior separates storage facts from response facts and tests the boundary explicitly. Be ready to explain the chapter in one minute using the named dataset, one positive case, one negative case, and the proof that catches the bug.

## What This Unlocks Next
This unlocks feed author cards and social graph views in chapter 04. The next chapter should feel less like a new topic and more like the natural consequence of the rows and rules you just proved.
