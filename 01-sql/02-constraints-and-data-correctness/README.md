# 02 Constraints and Data Correctness

## Scenario
Two follow requests for Ada following Ben arrive at the same time. The application can check first, but only the database can serialize the final truth.

## What This Chapter Teaches
This chapter teaches NOT NULL for required facts, UNIQUE for identity, CHECK for local invariants, FOREIGN KEY for relationship integrity, and composite primary keys for duplicate edge protection. The goal is not to memorize syntax. The goal is to see how a backend idea becomes rows, predicates, constraints, and proof assertions.

## Why This Matters In Real Backends
Concurrent backend requests do not politely wait for application validation. Constraint failures prove the database is doing its job. Application validation improves messages. Database constraints preserve truth.

## Named Dataset Story
- ada and ben have unique lower-case handles.
- ada follows ben once.
- cy and diya exist so invalid and valid relationship attempts are distinguishable.
- profiles are tied to existing users only.

## Files To Read In Order
1. `00-dataset.story.md` to understand why every named row exists.
2. `00-concept.explainer.md` for the backend mental model.
3. The numbered `.solution.sql` files in order; inspect the comments before running each query.
4. `99-chapter-proof.tests.sql` to see which claims are enforced mechanically.
5. `90-common-mistakes.sql` and `91-common-mistakes.explainer.md` after the correct version is clear.
6. `98-extension-tasks.md` when you are ready to break and repair the lesson.

## What To Inspect In Adminer Or DbGate
Load the chapter with `./scripts/forge-load.sh 01-sql/02-constraints-and-data-correctness`. Start by opening the base tables and finding the named rows. Then open the views created by the solution files and compare them with the positive and negative cases in the dataset story. Do not begin with the final query; begin with the rows that make the query necessary.

## What The Proof Tests Prove
- Positive: Ada to Ben follow is stored exactly once.
- Positive: profiles point at real users.
- Positive: handles are nonblank and lower-case.
- Negative/exclusion: duplicate Ada to Ben follow fails.
- Negative/exclusion: Ada to Ada self-follow fails.
- Negative/exclusion: follow to user 999 fails.
- Negative/exclusion: profile for user 999 fails.

## What To Deliberately Break
- drop the composite primary key on follows. Rerun `./scripts/forge-test.sh 01-sql/02-constraints-and-data-correctness` and read the failure before restoring the predicate or constraint.
- drop the self-follow CHECK. Rerun `./scripts/forge-test.sh 01-sql/02-constraints-and-data-correctness` and read the failure before restoring the predicate or constraint.
- drop the follows foreign keys. Rerun `./scripts/forge-test.sh 01-sql/02-constraints-and-data-correctness` and read the failure before restoring the predicate or constraint.

## Interview Explanation Target
A senior asks which invariant survives two web workers racing each other. Be ready to explain the chapter in one minute using the named dataset, one positive case, one negative case, and the proof that catches the bug.

## What This Unlocks Next
This unlocks safe public profile query shaping in chapter 03. The next chapter should feel less like a new topic and more like the natural consequence of the rows and rules you just proved.
