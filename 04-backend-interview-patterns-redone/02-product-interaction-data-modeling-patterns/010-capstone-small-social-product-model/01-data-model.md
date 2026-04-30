# Data Model

## Actual tables

`users, profiles, follow_edges, block_edges, posts, post_reactions, comments, swipe_events, matches, notifications, activity_events, user_interests, post_tags`.

## Trap rows

Ada sees Ben/Diya/Eli profiles, not Cy who blocked Ada or inactive Fay; home feed has Ben post 1001, variant also Eli post 1003; post 1001 counts only live reactions/comments; Ada/Diya match 5001 is active; unread notifications change from two to three.

## Constraints

Each contract is derived from normalized objects, relationships, events, and lifecycle state. Do not solve this as one giant raw join.

## Read contract

Compose small contracts: profile visibility uses profiles/follows/blocks; counts ignore deleted rows; match uses canonical active matches; notifications count unread; activity and home feed filter deleted, blocked, inactive, and followed state; recommendation candidates use shared interests with exclusions.
