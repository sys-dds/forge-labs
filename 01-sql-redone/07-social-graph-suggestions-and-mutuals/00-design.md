# Design

## What this clinic teaches

Directed graph queries depend on edge direction. Ada's following, followers, mutuals, and suggestions are different traversals over the same `follows` table.

## Named rows and why each exists

- Ada is the viewer.
- Ben is followed by Ada and follows Ada back, proving mutual logic.
- Cy is followed by Ada but does not follow Ada back, proving following is not mutual.
- Diya is reachable through Ben and Cy, proving duplicate second-degree paths.
- Noor is reachable through Cy but blocked by Ada.
- Omar follows Ada, proving incoming followers are not outgoing suggestions.
- Theo is disconnected.
- Maya is followed by Ada and creates another outgoing edge path to Diya.

## Broken query bug

The broken suggestions treat reachability as eligibility, include already-followed users, include blocked Noor, duplicate Diya, and confuse incoming followers with suggestions.

## Exact wrong result from the broken query

`ada_safe_suggestions` returns Ben, Cy, Diya twice, Maya, Noor, and Omar instead of one row for Diya.

## Correct result from the solution

Following is `ben`, `cy`, `maya`; followers are `ben`, `noor`, `omar`; mutuals are `ben`; safe suggestions contain only `diya`.

## Proof assertions

The proof checks exact following, followers, mutuals, suggestions, duplicate raw paths for Diya, Noor excluded, Theo absent, and Omar not suggested.

## What the learner should notice

`follower_id` is the actor/source and `followee_id` is the target; DISTINCT removes duplicate paths but block and already-followed exclusions decide safety.

## Interview explanation target

Explain directed edges, mutual follow logic, second-degree traversal, exclusion predicates, and why reachability is not eligibility.

