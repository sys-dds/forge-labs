# Data Model

## Actual tables
`users`, `follow_edges`, `block_edges`, and `posts`.

## Key columns
The ids identify durable product objects. State columns such as `active`, `status`, `visibility`, `deleted_at`, `unmatched_at`, and `blocked_at` decide whether a row participates in the read contract.

## Constraints
`follow_edges` has one row per follower/followee pair. `block_edges` has one row per blocker/blocked pair. Self follows are blocked by a check constraint.

## Why each table exists
Each table separates durable objects from relationship/event history so reads can apply the product rules explicitly.

## Trap rows
Ada follows Ben, Ben does not follow Ada, Cy unfollowed Ben, Omar follows Ben but Ben blocks Omar, and Ben has a post visibility check.
