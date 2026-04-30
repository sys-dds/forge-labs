# Data Model

## Actual tables
`users`, `user_profiles`, `swipe_events`, `matches`, `block_edges`, and `report_events`.

## Key columns
The ids identify durable product objects. State columns such as `active`, `status`, `visibility`, `deleted_at`, `unmatched_at`, and `blocked_at` decide whether a row participates in the read contract.

## Constraints
`matches` stores canonical user pairs with a unique key and optional `unmatched_at`. Swipe history keeps events, not final truth alone.

## Why each table exists
Each table separates durable objects from relationship/event history so reads can apply the product rules explicitly.

## Trap rows
Ada right-swipes Ben one-way, Ada and Cy mutually right-swipe, Ada left-swipes Diya, Omar is blocked, Noor is reported, Lina is unmatched, and Maya is a candidate.
