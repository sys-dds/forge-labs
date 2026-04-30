# Data Model

## Actual tables

`users, posts, friendships, audience_groups, audience_group_members, block_edges`.

## Trap rows

viewer Ada 1 sees public post 201, cannot see Ben private post 202, sees own private post 203, sees Cy friends-only post 204, sees Diya close-friends post 205 only while group member 1 exists, cannot see Eli close-friends post 206, cannot see Omar blocked post 207, and cannot see deleted post 208.

## Constraints

Blocks override every visibility setting, deleted posts are hidden, owner visibility is explicit, and close-friends visibility comes from audience_group_members.

## Read contract

Build visible_posts by joining posts to users, accepted friendships, audience group membership, and block_edges for viewer 1; then emit visible and hidden contract counts.
