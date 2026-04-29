# 05 Joins and Feed Candidates

## Scenario
Ada opens her feed. SQL must decide which posts are eligible before any ranking layer scores them.

## What This Chapter Teaches
This chapter teaches INNER JOIN for required follows, LEFT JOIN for optional metrics, NOT EXISTS anti-joins for exclusions, and row multiplication caused by multiple child tables. The goal is not to memorize syntax. The goal is to see how a backend idea becomes rows, predicates, constraints, and proof assertions.

## Why This Matters In Real Backends
Ranking blocked or muted content is already a backend bug. Candidate generation is the safety gate before scoring. Eligible rows first, scoring later. Joins are policy, not just data retrieval.

## Named Dataset Story
- ada follows ben, cy, and noor.
- ada mutes cy and blocks noor.
- diya is not followed.
- ben posts 101 and 102.
- cy post 201, noor post 301, diya post 401.
- post 101 has two likes and three comments.

## Files To Read In Order
1. `00-dataset.story.md` to understand why every named row exists.
2. `00-concept.explainer.md` for the backend mental model.
3. The numbered `.solution.sql` files in order; inspect the comments before running each query.
4. `99-chapter-proof.tests.sql` to see which claims are enforced mechanically.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md` after the correct version is clear.
6. `98-extension-tasks.md` when you are ready to break and repair the lesson.

## What To Inspect In Adminer Or DbGate
Load the chapter with `./scripts/forge-load.sh 01-sql/05-joins-and-feed-candidates`. Start by opening the base tables and finding the named rows. Then open the views created by the solution files and compare them with the positive and negative cases in the dataset story. Do not begin with the final query; begin with the rows that make the query necessary.

## What The Proof Tests Prove
- Positive: feed candidates are Ben posts 101 and 102.
- Positive: post 102 survives despite zero comments.
- Positive: author profile fields are attached.
- Negative/exclusion: cy is excluded by mute.
- Negative/exclusion: noor is excluded by block.
- Negative/exclusion: diya is excluded because Ada does not follow her.
- Negative/exclusion: bad multiplication query inflates post 101.

## What To Deliberately Break
- remove mute predicate. Rerun `./scripts/forge-test.sh 01-sql/05-joins-and-feed-candidates` and read the failure before restoring the predicate or constraint.
- remove block predicate. Rerun `./scripts/forge-test.sh 01-sql/05-joins-and-feed-candidates` and read the failure before restoring the predicate or constraint.
- join likes and comments directly and count rows. Rerun `./scripts/forge-test.sh 01-sql/05-joins-and-feed-candidates` and read the failure before restoring the predicate or constraint.

## Interview Explanation Target
A senior checks candidate eligibility before debating ranking math. Be ready to explain the chapter in one minute using the named dataset, one positive case, one negative case, and the proof that catches the bug.

## What This Unlocks Next
This unlocks aggregation and metrics in chapter 06. The next chapter should feel less like a new topic and more like the natural consequence of the rows and rules you just proved.
