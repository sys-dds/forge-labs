# Data Model

## Actual tables
`users`, `profiles`, `profile_field_visibility`, and `user_blocks`.

## Key columns
The ids identify durable product objects. State columns such as `active`, `status`, `visibility`, `deleted_at`, `unmatched_at`, and `blocked_at` decide whether a row participates in the read contract.

## Constraints
Unique `profiles.handle` prevents ambiguous URLs. `profile_field_visibility` uses a composite key so each profile field has one rule. `user_blocks` prevents duplicate block rows.

## Why each table exists
Each table separates durable objects from relationship/event history so reads can apply the product rules explicitly.

## Trap rows
Ada owns `ada_dev`, Omar is blocked by Ada, Diya is deactivated, and the variant makes `ben_ops` expose a previously private field.
