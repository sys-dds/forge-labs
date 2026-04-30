# How To Explain In Interview

## Direct answer

Model visibility as a query contract over posts, relationships, audience groups, and blocks instead of a display-only flag.

## Actual tables

Use `users, posts, friendships, audience_groups, audience_group_members, block_edges` in schema `bip_pim_012`.

## Actual trap rows

viewer Ada 1 sees public post 201, cannot see Ben private post 202, sees own private post 203, sees Cy friends-only post 204, sees Diya close-friends post 205 only while group member 1 exists, cannot see Eli close-friends post 206, cannot see Omar blocked post 207, and cannot see deleted post 208.

## Exact query mechanics

Build visible_posts by joining posts to users, accepted friendships, audience group membership, and block_edges for viewer 1; then emit visible and hidden contract counts.

## Write path

Create posts with visibility and optional audience_group_id, maintain friendship and audience_group_members rows separately, and write block_edges as an override.

## Scaling follow-up

Visibility can be precomputed later, but the query contract must keep owner, friendship, group membership, block, and deletion rules separate.
