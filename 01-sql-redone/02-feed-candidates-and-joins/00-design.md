# Design

## What this clinic teaches

Feed candidate generation must remove ineligible rows before ranking and must attach optional engagement without losing posts.

## Named rows and why each exists

- Ben post 102 is newer, visible, and has zero comments.
- Ben post 101 is visible with 2 likes and 3 comments.
- Cy post 201 is followed but muted by Ada.
- Noor post 301 is followed but blocked by Ada.
- Diya post 401 is visible but unfollowed.
- Ben post 103 is hidden.

## Broken query bug

The broken query misses mute/block/hidden filters and joins comments directly, removing Ben post 102 and inflating Ben post 101.

## Exact wrong result from the broken query

Ada's feed contains ineligible Cy/Noor/hidden rows and does not return exactly post 102 then post 101 with counts 1/0 and 2/3.

## Correct result from the solution

Ada's feed returns post 102 first and post 101 second, with exact like and comment counts.

## Proof assertions

The proof checks exact post ids/order, Cy/Noor/Diya/hidden exclusions, and exact counts for Ben posts 101 and 102.

## What the learner should notice

Mutes and blocks are eligibility filters, and zero-comment posts need left joins or separate aggregation.

## Interview explanation target

Explain viewer to follows to authors to posts, anti-join exclusions, separate aggregation, and candidate set before ranking.

