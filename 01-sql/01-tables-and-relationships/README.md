# 01 Tables and Relationships

## Scenario
A tiny social product is being modeled from zero. Ada, Ben, Cy, and Diya are durable identity facts queried through profiles, posts, settings, and early follow edges.

## What This Chapter Teaches
This chapter teaches users as identity facts, profiles as true one-to-one rows, posts as one-to-many rows, settings as optional one-to-one data, and follows_preview as the first many-to-many edge list. The goal is not to memorize syntax. The goal is to see how a backend idea becomes rows, predicates, constraints, and proof assertions.

## Why This Matters In Real Backends
If the relationship is modeled loosely now, future profile, feed, and social graph queries inherit that looseness. A table is a domain claim before it is storage. Cardinality is part of the API contract.

## Named Dataset Story
- ada has a profile, optional settings, two posts, and preview follows to ben and cy.
- ben has a profile, one post, and intentionally no settings.
- cy has a profile and exists as a second follow target.
- diya has a profile and proves the model supports users before they post or receive settings.

## Files To Read In Order
1. `00-dataset.story.md` to understand why every named row exists.
2. `00-concept.explainer.md` for the backend mental model.
3. The numbered `.solution.sql` files in order; inspect the comments before running each query.
4. `99-chapter-proof.tests.sql` to see which claims are enforced mechanically.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md` after the correct version is clear.
6. `98-extension-tasks.md` when you are ready to break and repair the lesson.

## What To Inspect In Adminer Or DbGate
Load the chapter with `./scripts/forge-load.sh 01-sql/01-tables-and-relationships`. Start by opening the base tables and finding the named rows. Then open the views created by the solution files and compare them with the positive and negative cases in the dataset story. Do not begin with the final query; begin with the rows that make the query necessary.

## What The Proof Tests Prove
- Positive: Ada can own multiple posts without duplicating Ada herself.
- Positive: Ben can exist without a settings row.
- Positive: Ada can follow Ben and Cy as two separate relationship facts.
- Negative/exclusion: duplicate profile for Ada is rejected.
- Negative/exclusion: post with missing author is rejected.
- Negative/exclusion: duplicate Ada to Ben preview follow is rejected.

## What To Deliberately Break
- remove the unique protection on user_profiles.user_id. Rerun `./scripts/forge-test.sh 01-sql/01-tables-and-relationships` and read the failure before restoring the predicate or constraint.
- remove the posts.author_id foreign key. Rerun `./scripts/forge-test.sh 01-sql/01-tables-and-relationships` and read the failure before restoring the predicate or constraint.
- replace the composite follows_preview key with only a surrogate id. Rerun `./scripts/forge-test.sh 01-sql/01-tables-and-relationships` and read the failure before restoring the predicate or constraint.

## Interview Explanation Target
A senior notices that optional settings deserve their own table once the setting group can grow independently from identity. Be ready to explain the chapter in one minute using the named dataset, one positive case, one negative case, and the proof that catches the bug.

## What This Unlocks Next
This unlocks constraint-backed correctness in chapter 02. The next chapter should feel less like a new topic and more like the natural consequence of the rows and rules you just proved.
