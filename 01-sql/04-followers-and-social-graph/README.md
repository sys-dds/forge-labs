# 04 Followers and Social Graph

## Scenario
Ada opens People you may know. The graph can reach several users, but reachability is not eligibility.

## What This Chapter Teaches
This chapter teaches directed edge lists, followers, following, mutual follows, second-degree suggestions, blocks, mutes, and visibility filtering. The goal is not to memorize syntax. The goal is to see how a backend idea becomes rows, predicates, constraints, and proof assertions.

## Why This Matters In Real Backends
Most social graph bugs are direction bugs or missing exclusion predicates. follower_id is the actor/source; followee_id is the target. Every traversal must say which direction it walks.

## Named Dataset Story
- ada follows ben and cy.
- ben follows ada and diya.
- cy follows diya and noor.
- diya and noor follow ada.
- theo is disconnected.
- ada blocks noor and mutes cy.

## Files To Read In Order
1. `00-dataset.story.md` to understand why every named row exists.
2. `00-concept.explainer.md` for the backend mental model.
3. The numbered `.solution.sql` files in order; inspect the comments before running each query.
4. `99-chapter-proof.tests.sql` to see which claims are enforced mechanically.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md` after the correct version is clear.
6. `98-extension-tasks.md` when you are ready to break and repair the lesson.

## What To Inspect In Adminer Or DbGate
Load the chapter with `./scripts/forge-load.sh 01-sql/04-followers-and-social-graph`. Start by opening the base tables and finding the named rows. Then open the views created by the solution files and compare them with the positive and negative cases in the dataset story. Do not begin with the final query; begin with the rows that make the query necessary.

## What The Proof Tests Prove
- Positive: Ada following is ben and cy.
- Positive: Ada followers are ben, diya, and noor.
- Positive: Ada mutual follows are ben.
- Positive: Ada suggestions are diya only.
- Negative/exclusion: noor is reachable but blocked.
- Negative/exclusion: cy remains followed but hidden from feed-style output.
- Negative/exclusion: theo never appears accidentally.

## What To Deliberately Break
- reverse follower_id and followee_id in followers query. Rerun `./scripts/forge-test.sh 01-sql/04-followers-and-social-graph` and read the failure before restoring the predicate or constraint.
- remove already-followed exclusion. Rerun `./scripts/forge-test.sh 01-sql/04-followers-and-social-graph` and read the failure before restoring the predicate or constraint.
- remove blocked exclusion from suggestions. Rerun `./scripts/forge-test.sh 01-sql/04-followers-and-social-graph` and read the failure before restoring the predicate or constraint.

## Interview Explanation Target
A senior reads a graph query by narrating each edge hop and each exclusion. Be ready to explain the chapter in one minute using the named dataset, one positive case, one negative case, and the proof that catches the bug.

## What This Unlocks Next
This unlocks feed candidate generation in chapter 05. The next chapter should feel less like a new topic and more like the natural consequence of the rows and rules you just proved.
