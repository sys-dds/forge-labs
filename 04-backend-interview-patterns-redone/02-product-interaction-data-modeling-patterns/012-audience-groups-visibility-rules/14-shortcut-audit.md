# Shortcut Audit

## Likely shortcut

Filter with visibility not equal private and ignore groups, owner, blocks, and deletes.

## How base proof catches it

The base proof checks viewer Ada 1 sees public post 201, cannot see Ben private post 202, sees own private post 203, sees Cy friends-only post 204, sees Diya close-friends post 205 only while group member 1 exists, cannot see Eli close-friends post 206, cannot see Omar blocked post 207, and cannot see deleted post 208.

## How variant proof catches it

The variant removes Ada from Diya close-friends group, changing close_friends_visible from 1 to 0.

## What mutation should fail

Remove the block override or group-membership predicate.

## What learner should inspect manually

Inspect `users, posts, friendships, audience_groups, audience_group_members, block_edges` and the base and variant expected CSV files.
