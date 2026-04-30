# Design

## What this clinic teaches

Choose the output grain before joining independent child tables.

## Named rows and why each exists

- Ada post A1 has 2 likes and 3 comments, creating 6 raw joined rows.
- Ada post A2 has 1 like and 0 comments.
- Ada post A3 is hidden with 5 likes and 5 comments.
- Ben post B1 has 3 likes and 1 comment.
- Cy has no posts and should still appear in author metrics.

## Broken query bug

The broken query joins posts, likes, and comments directly, includes hidden A3, and drops zero-comment A2.

## Exact wrong result from the broken query

A1 counts joined combinations, A2 disappears, A3 affects Ada totals, and author metrics no longer match visible post facts.

## Correct result from the solution

Post metrics are A1 2/3, A2 1/0, and B1 3/1; author metrics include Ada 2/3/3, Ben 1/3/1, and Cy 0/0/0.

## Proof assertions

The proof checks A1 raw join count 6, hidden A3 exclusion, A2 survival, exact post metrics, and exact author metrics.

## What the learner should notice

Likes and comments are independent child tables; counting after joining them measures combinations.

## Interview explanation target

Explain choosing output grain first, aggregating child tables separately, and joining summaries back to parent rows.

## Row removal checks

- Wrong behavior if removed: without A1, row multiplication from 2 likes and 3 comments is not visible.
- Wrong behavior if removed: without A2, zero-comment survival is not tested.
- Wrong behavior if removed: without A3, hidden-post exclusion is not tested.
- Wrong behavior if removed: without B1, non-Ada post metrics have no comparison row.
- Wrong behavior if removed: without Cy, zero-post author summaries are not proven.
