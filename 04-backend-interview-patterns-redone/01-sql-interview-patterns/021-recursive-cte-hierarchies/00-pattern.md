# Pattern

## What this clinic practices
WITH RECURSIVE hierarchy traversal.

## Actual tables
`categories(category_id, category_name, parent_category_id, active)` stores the services tree and deliberately bad rows.

## Actual rows that trap the learner
`services` is the root, `sink repair` is deep, `blocked child` sits below disabled `blocked services`, `ghost child` is outside the root, and `cycle a`/`cycle b` form a bad cycle.

## Why the broken query fails
The broken query joins only one level below `services`, so it misses deeper descendants and has no cycle guard.

## Correct query shape
Start at active `services`, recurse only through active children, carry a visited id path and depth, and order by path text.

## Interview wording
Name the relational rule first, then name the guardrail that keeps the answer stable across the variant seed.
