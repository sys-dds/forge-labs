# Read/Write Path

## Write path

Write profiles, follows, blocks, posts, reactions, comments, swipes, matches, notifications, activity events, and interests to their own tables.

## Read path

Compose small contracts: profile visibility uses profiles/follows/blocks; counts ignore deleted rows; match uses canonical active matches; notifications count unread; activity and home feed filter deleted, blocked, inactive, and followed state; recommendation candidates use shared interests with exclusions.
