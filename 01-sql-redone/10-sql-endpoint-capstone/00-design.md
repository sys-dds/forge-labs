# Design

## What this clinic teaches

An endpoint query combines graph candidate generation, safety exclusions, shaped projection, isolated aggregation, visible activity requirements, and stable ordering.

## Named rows and why each exists

- Ada is the viewer.
- Ben is already followed by Ada and must be excluded even though Ben has visible posts.
- Cy is blocked by Ada and must be excluded even though Cy has visible posts.
- Diya is a valid second-degree creator with two visible posts and three followers.
- Noor is private/non-searchable.
- Maya is a valid second-degree creator with one visible post and two followers.
- Omar is public but has only hidden posts.
- Theo is disconnected.
- Lina is a valid second-degree creator with the same latest timestamp and follower count as Maya, proving id tie-break order.

## Broken query bug

The broken endpoint browses raw users, includes email, leaks Ben, Cy, Noor, Omar, and Theo, and joins posts/followers in one rowset.

## Exact wrong result from the broken query

The broken page includes Ada, Ben, Cy, Noor, Omar, and Theo, exposes email, and reports inflated counts such as Diya follower_count 6 from two visible posts times three followers.

## Correct result from the solution

The endpoint returns Diya, Lina, and Maya in that order with exact follower_count, mutual_follow_count, recent_visible_post_count, reason_label, cursor_created_at, and cursor_creator_id.

## Proof assertions

The proof checks exact handles and order, all exclusions, exact counts, stable Lina/Maya tie ordering, and absence of email/private fields.

## What the learner should notice

The endpoint is not a table dump: candidates, exclusions, counts, and cursor fields are all part of the contract.

## Interview explanation target

Explain endpoint projection, graph candidates, exclusion-before-ranking, aggregation grain, stable cursor fields, and how to evolve performance without removing safety predicates.

