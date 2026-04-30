# Data Model

## Actual tables
`users`, `posts`, `post_reactions`, and `comments`.

## Key columns
The ids identify durable product objects. State columns such as `active`, `status`, `visibility`, `deleted_at`, `unmatched_at`, and `blocked_at` decide whether a row participates in the read contract.

## Constraints
Reaction history uses event rows; only latest active reaction per user/content counts. Comments keep parent ids and soft-delete timestamps.

## Why each table exists
Each table separates durable objects from relationship/event history so reads can apply the product rules explicitly.

## Trap rows
Ada likes once then removes a later reaction, Ben has an active like, one comment is soft-deleted, and one reply hangs under the visible comment.
