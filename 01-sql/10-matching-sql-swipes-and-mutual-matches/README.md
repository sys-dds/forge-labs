# 10 Matching SQL, Swipes, and Mutual Matches

## Scenario
Ada opens matching candidates. SQL removes unsafe and impossible candidates before any ranking score is computed.

## What This Chapter Teaches
This chapter teaches profiles, preferences, swipes as directed actions, duplicate/self-action prevention, mutual LIKE detection, raw candidate exclusions, and preference fit. The goal is not to memorize syntax. The goal is to see how a backend idea becomes rows, predicates, constraints, and proof assertions.

## Why This Matters In Real Backends
Ranking bad candidates wastes work and can be unsafe. PASS is a decision, inactive users are not candidates, and blocked users must never reach scoring. Exclusions are the first matching algorithm. Only then should scoring begin.

## Named Dataset Story
- ada is active age 30 in Glasgow with sql hiking coffee interests.
- ben is active, overlaps with Ada, and has mutual LIKE.
- cy is active but Ada passed Cy.
- diya is active but blocked by Ada.
- noor is inactive.
- maya is active, unswiped, Glasgow, and overlaps two interests.
- omar is active and unswiped but outside preference fit.

## Files To Read In Order
1. `00-dataset.story.md` to understand why every named row exists.
2. `00-concept.explainer.md` for the backend mental model.
3. The numbered `.solution.sql` files in order; inspect the comments before running each query.
4. `99-chapter-proof.tests.sql` to see which claims are enforced mechanically.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md` after the correct version is clear.
6. `98-extension-tasks.md` when you are ready to break and repair the lesson.

## What To Inspect In Adminer Or DbGate
Load the chapter with `./scripts/forge-load.sh 01-sql/10-matching-sql-swipes-and-mutual-matches`. Start by opening the base tables and finding the named rows. Then open the views created by the solution files and compare them with the positive and negative cases in the dataset story. Do not begin with the final query; begin with the rows that make the query necessary.

## What The Proof Tests Prove
- Positive: mutual match is Ada-Ben only.
- Positive: raw candidates are Maya and Omar.
- Positive: preference-fit candidate is Maya only.
- Positive: Maya shares two interests.
- Negative/exclusion: duplicate and self swipes fail.
- Negative/exclusion: Cy PASS does not match.
- Negative/exclusion: Diya blocked excluded.
- Negative/exclusion: Noor inactive excluded.
- Negative/exclusion: Ben/Cy already swiped excluded.

## What To Deliberately Break
- treat any reciprocal swipe as match. Rerun `./scripts/forge-test.sh 01-sql/10-matching-sql-swipes-and-mutual-matches` and read the failure before restoring the predicate or constraint.
- remove already-swiped exclusion. Rerun `./scripts/forge-test.sh 01-sql/10-matching-sql-swipes-and-mutual-matches` and read the failure before restoring the predicate or constraint.
- mix preference fit into raw safety exclusions. Rerun `./scripts/forge-test.sh 01-sql/10-matching-sql-swipes-and-mutual-matches` and read the failure before restoring the predicate or constraint.

## Interview Explanation Target
A senior separates safety exclusions from preference scoring and proves both layers. Be ready to explain the chapter in one minute using the named dataset, one positive case, one negative case, and the proof that catches the bug.

## What This Unlocks Next
This unlocks future ranking and matching algorithms after the SQL foundation is reviewed. The next chapter should feel less like a new topic and more like the natural consequence of the rows and rules you just proved.
