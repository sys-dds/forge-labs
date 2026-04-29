# 08 Pagination and Cursors

## Scenario
Ada scrolls a feed while new posts are being created above the rows she already saw.

## What This Chapter Teaches
This chapter teaches offset pagination, offset instability, keyset pagination, stable sort pairs, cursor shape, and DESC keyset comparisons. The goal is not to memorize syntax. The goal is to see how a backend idea becomes rows, predicates, constraints, and proof assertions.

## Why This Matters In Real Backends
Page numbers are convenient for static lists. Feeds move, so the next request needs the last seen key, not an offset guess. A cursor is the last row boundary, usually made from the same columns used to order results.

## Named Dataset Story
- six posts exist before scrolling.
- two posts share the exact same created_at.
- a new post appears before offset page two.
- ids disambiguate timestamp ties.
- cursor page one returns a documented boundary.

## Files To Read In Order
1. `00-dataset.story.md` to understand why every named row exists.
2. `00-concept.explainer.md` for the backend mental model.
3. The numbered `.solution.sql` files in order; inspect the comments before running each query.
4. `99-chapter-proof.tests.sql` to see which claims are enforced mechanically.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md` after the correct version is clear.
6. `98-extension-tasks.md` when you are ready to break and repair the lesson.

## What To Inspect In Adminer Or DbGate
Load the chapter with `./scripts/forge-load.sh 01-sql/08-pagination-and-cursors`. Start by opening the base tables and finding the named rows. Then open the views created by the solution files and compare them with the positive and negative cases in the dataset story. Do not begin with the final query; begin with the rows that make the query necessary.

## What The Proof Tests Prove
- Positive: keyset page one and page two return exact ids.
- Positive: timestamp ties order by id.
- Positive: cursor contains created_at and id.
- Negative/exclusion: offset page two differs after insert.
- Negative/exclusion: created_at alone cannot identify a boundary.
- Negative/exclusion: DESC comparison must move older than the boundary.

## What To Deliberately Break
- remove id from ORDER BY. Rerun `./scripts/forge-test.sh 01-sql/08-pagination-and-cursors` and read the failure before restoring the predicate or constraint.
- use OFFSET after inserting a new post. Rerun `./scripts/forge-test.sh 01-sql/08-pagination-and-cursors` and read the failure before restoring the predicate or constraint.
- reverse the DESC comparison. Rerun `./scripts/forge-test.sh 01-sql/08-pagination-and-cursors` and read the failure before restoring the predicate or constraint.

## Interview Explanation Target
A senior designs pagination around list movement, not around page numbers. Be ready to explain the chapter in one minute using the named dataset, one positive case, one negative case, and the proof that catches the bug.

## What This Unlocks Next
This unlocks recursive comment trees in chapter 09. The next chapter should feel less like a new topic and more like the natural consequence of the rows and rules you just proved.
