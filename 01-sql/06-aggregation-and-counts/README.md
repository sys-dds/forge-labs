# 06 Aggregation and Counts

## Scenario
A profile/feed service needs counts for cards and ranking inputs. The numbers become product facts users trust.

## What This Chapter Teaches
This chapter teaches COUNT, COUNT(column), SUM, AVG, GROUP BY, HAVING, visible-row filters, and COUNT DISTINCT when joins duplicate rows. The goal is not to memorize syntax. The goal is to see how a backend idea becomes rows, predicates, constraints, and proof assertions.

## Why This Matters In Real Backends
Bad metrics create broken trust and bad ranking inputs. Hidden posts and deleted comments change product truth. Aggregation collapses rows; decide the entity you want one output row for before writing the join.

## Named Dataset Story
- ada has two visible posts and one hidden post.
- ben has one visible post.
- cy has no posts.
- diya has one hidden-style post.
- Ada post A1 has two likes, two visible comments, and one deleted comment.
- Ben and Cy follow Ada.

## Files To Read In Order
1. `00-dataset.story.md` to understand why every named row exists.
2. `00-concept.explainer.md` for the backend mental model.
3. The numbered `.solution.sql` files in order; inspect the comments before running each query.
4. `99-chapter-proof.tests.sql` to see which claims are enforced mechanically.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md` after the correct version is clear.
6. `98-extension-tasks.md` when you are ready to break and repair the lesson.

## What To Inspect In Adminer Or DbGate
Load the chapter with `./scripts/forge-load.sh 01-sql/06-aggregation-and-counts`. Start by opening the base tables and finding the named rows. Then open the views created by the solution files and compare them with the positive and negative cases in the dataset story. Do not begin with the final query; begin with the rows that make the query necessary.

## What The Proof Tests Prove
- Positive: Ada visible post count is two.
- Positive: A1 visible comment count is two.
- Positive: Ben has three likes on one post.
- Positive: HAVING returns authors above threshold.
- Negative/exclusion: hidden posts are excluded.
- Negative/exclusion: deleted comments are excluded.
- Negative/exclusion: direct joined count is larger than distinct count.

## What To Deliberately Break
- remove hidden filter. Rerun `./scripts/forge-test.sh 01-sql/06-aggregation-and-counts` and read the failure before restoring the predicate or constraint.
- count comments with deleted rows included. Rerun `./scripts/forge-test.sh 01-sql/06-aggregation-and-counts` and read the failure before restoring the predicate or constraint.
- replace HAVING with WHERE on an aggregate. Rerun `./scripts/forge-test.sh 01-sql/06-aggregation-and-counts` and read the failure before restoring the predicate or constraint.

## Interview Explanation Target
A senior treats metric queries as product logic with testable exclusions. Be ready to explain the chapter in one minute using the named dataset, one positive case, one negative case, and the proof that catches the bug.

## What This Unlocks Next
This unlocks window functions and ranking input preparation in chapter 07. The next chapter should feel less like a new topic and more like the natural consequence of the rows and rules you just proved.
