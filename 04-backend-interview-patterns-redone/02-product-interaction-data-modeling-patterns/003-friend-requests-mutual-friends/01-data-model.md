# Data Model

## Actual tables
`users`, `friend_requests`, `friendships`, and `block_edges`.

## Key columns
The ids identify durable product objects. State columns such as `active`, `status`, `visibility`, `deleted_at`, `unmatched_at`, and `blocked_at` decide whether a row participates in the read contract.

## Constraints
`friendships` stores canonical low/high user ids with a unique primary key. Requests retain lifecycle state without implying friendship.

## Why each table exists
Each table separates durable objects from relationship/event history so reads can apply the product rules explicitly.

## Trap rows
Ada and Ben are friends, Ada and Cy only have pending request, Diya declined Ada, Omar is blocked, and Lina is mutual friend between Ada and Ben.
