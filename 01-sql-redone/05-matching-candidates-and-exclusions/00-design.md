# Design

## What this clinic teaches

Matching candidate queries must separate mutual matches, raw eligibility exclusions, and preference fit.

## Named rows and why each exists

- Ada is the viewer.
- Ben has two LIKE rows with Ada and is a mutual match.
- Cy liked Ada, but Ada passed Cy.
- Diya is active but blocked by Ada.
- Noor is inactive.
- Maya is active, unswiped, in preference, and shares two interests.
- Omar is active and unswiped but outside Ada's preference.

## Broken query bug

The broken query treats PASS like LIKE, keeps already-swiped users as candidates, includes blocked and inactive users, and mixes preference fit before safety exclusions.

## Exact wrong result from the broken query

Cy can appear as a false match, and raw candidates include users Ada already handled or must not see.

## Correct result from the solution

Mutual matches contain Ben only, raw candidates contain Maya and Omar, and preference-fit candidates contain Maya with shared_interest_count 2.

## Proof assertions

The proof checks duplicate/self swipe rejection, Cy PASS not matching, Ben/Cy/Diya/Noor/Ada exclusions, exact raw candidates, exact fit candidates, and Maya's shared interest count.

## What the learner should notice

LIKE and PASS are directed decisions, and preference fit should not rescue unsafe candidates.

## Interview explanation target

Explain mutual match detection, raw candidate exclusion, preference fit, and why ranking comes after exclusions.

## Row removal checks

- Wrong behavior if removed: without Ben, mutual match detection has no valid match.
- Wrong behavior if removed: without Cy, PASS versus LIKE is not tested.
- Wrong behavior if removed: without Diya, block exclusion is not tested.
- Wrong behavior if removed: without Noor, inactive-user exclusion is not tested.
- Wrong behavior if removed: without Maya, preference-fit candidate output is empty.
