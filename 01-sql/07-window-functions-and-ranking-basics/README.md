# 07 Window Functions and Ranking Inputs

## Scenario
The backend prepares rows for a future ranking system without pretending SQL rank labels are the algorithm.

## What This Chapter Teaches
This chapter teaches ROW_NUMBER, RANK, DENSE_RANK, PARTITION BY, deterministic tie-breakers, running totals, and raw ranking input columns. The goal is not to memorize syntax. The goal is to see how a backend idea becomes rows, predicates, constraints, and proof assertions.

## Why This Matters In Real Backends
Window functions compare rows without collapsing them. That makes them ideal for latest-per-author and ordered signals. A window keeps every row visible while adding context from neighboring rows.

## Named Dataset Story
- ada has three posts with a clear latest id.
- ben has two posts.
- cy has one post.
- two posts tie on engagement.
- two authors tie on follower count.
- engagement events are ordered per author.

## Files To Read In Order
1. `00-dataset.story.md` to understand why every named row exists.
2. `00-concept.explainer.md` for the backend mental model.
3. The numbered `.solution.sql` files in order; inspect the comments before running each query.
4. `99-chapter-proof.tests.sql` to see which claims are enforced mechanically.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md` after the correct version is clear.
6. `98-extension-tasks.md` when you are ready to break and repair the lesson.

## What To Inspect In Adminer Or DbGate
Load the chapter with `./scripts/forge-load.sh 01-sql/07-window-functions-and-ranking-basics`. Start by opening the base tables and finding the named rows. Then open the views created by the solution files and compare them with the positive and negative cases in the dataset story. Do not begin with the final query; begin with the rows that make the query necessary.

## What The Proof Tests Prove
- Positive: latest per author returns one exact post each.
- Positive: RANK leaves a gap after a tie.
- Positive: DENSE_RANK does not leave a gap.
- Positive: running total restarts per author.
- Negative/exclusion: missing tie-breaker is nondeterministic.
- Negative/exclusion: running total without partition mixes authors.
- Negative/exclusion: ranking input is not a final algorithm.

## What To Deliberately Break
- remove id tie-breaker. Rerun `./scripts/forge-test.sh 01-sql/07-window-functions-and-ranking-basics` and read the failure before restoring the predicate or constraint.
- remove PARTITION BY. Rerun `./scripts/forge-test.sh 01-sql/07-window-functions-and-ranking-basics` and read the failure before restoring the predicate or constraint.
- filter ROW_NUMBER in the same SELECT layer. Rerun `./scripts/forge-test.sh 01-sql/07-window-functions-and-ranking-basics` and read the failure before restoring the predicate or constraint.

## Interview Explanation Target
A senior uses window output as labeled evidence, not as a finished recommendation system. Be ready to explain the chapter in one minute using the named dataset, one positive case, one negative case, and the proof that catches the bug.

## What This Unlocks Next
This unlocks stable cursor pagination in chapter 08. The next chapter should feel less like a new topic and more like the natural consequence of the rows and rules you just proved.
