# 09 Comments and Recursive Queries

## Scenario
A post has nested comments, and the backend needs the whole thread with depth and stable path ordering.

## What This Chapter Teaches
This chapter teaches parent-child rows, base case, recursive step, depth, path, scope filters, and category trees using the same shape. The goal is not to memorize syntax. The goal is to see how a backend idea becomes rows, predicates, constraints, and proof assertions.

## Why This Matters In Real Backends
Recursive CTEs are repeated joins against rows already found. The hard parts are choosing the base, staying scoped, and ordering the result. Base case chooses the root; recursive step finds children; path turns a tree into a stable list.

## Named Dataset Story
- post 100 has c1 root, c2 and c3 replies, c4 under c2, c5 under c4.
- post 200 has c6 and c7 to prove scope.
- categories include Electronics, Computers, Laptops, Phones, Home.

## Files To Read In Order
1. `00-dataset.story.md` to understand why every named row exists.
2. `00-concept.explainer.md` for the backend mental model.
3. The numbered `.solution.sql` files in order; inspect the comments before running each query.
4. `99-chapter-proof.tests.sql` to see which claims are enforced mechanically.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md` after the correct version is clear.
6. `98-extension-tasks.md` when you are ready to break and repair the lesson.

## What To Inspect In Adminer Or DbGate
Load the chapter with `./scripts/forge-load.sh 01-sql/09-comments-and-recursive-queries`. Start by opening the base tables and finding the named rows. Then open the views created by the solution files and compare them with the positive and negative cases in the dataset story. Do not begin with the final query; begin with the rows that make the query necessary.

## What The Proof Tests Prove
- Positive: direct replies to c1 are c2 and c3.
- Positive: recursive thread order is c1,c2,c4,c5,c3.
- Positive: depths are exact.
- Positive: category tree uses same recursion pattern.
- Negative/exclusion: post 200 comments are excluded.
- Negative/exclusion: invalid parent comment fails.
- Negative/exclusion: unstable path ordering is visible.

## What To Deliberately Break
- remove post_id scope. Rerun `./scripts/forge-test.sh 01-sql/09-comments-and-recursive-queries` and read the failure before restoring the predicate or constraint.
- remove parent foreign key. Rerun `./scripts/forge-test.sh 01-sql/09-comments-and-recursive-queries` and read the failure before restoring the predicate or constraint.
- order only by created_at instead of path. Rerun `./scripts/forge-test.sh 01-sql/09-comments-and-recursive-queries` and read the failure before restoring the predicate or constraint.

## Interview Explanation Target
A senior can explain recursive SQL as a loop with a base result and a child expansion. Be ready to explain the chapter in one minute using the named dataset, one positive case, one negative case, and the proof that catches the bug.

## What This Unlocks Next
This unlocks matching candidate filtering in chapter 10. The next chapter should feel less like a new topic and more like the natural consequence of the rows and rules you just proved.
