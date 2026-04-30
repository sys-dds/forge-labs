# Data Model

## Actual tables

- `users`
- `communities`
- `community_memberships`
- `community_channels`
- `channel_memberships`
- `community_posts`
- `community_threads`
- `community_post_moderation_actions`

## Constraints

- Community posts belong to a channel and community.
- Private channels require channel_memberships.
- Removed or banned community members cannot see posts.
- Deleted or removed posts are suppressed from visible post contracts.
- Thread replies retain parent_post_id links.

## Trap rows

- Ada user 1 is active and sees public post 1001.
- Ben user 2 is channel member 5002 and sees private post 1002.
- Cy user 3 is active but not in channel 202 and must not see post 1002.
- Diya user 4 has removed membership 3004 and must see no posts.
- Post 1004 is deleted and post 1005 is removed by moderation action 7001.

## Why this shape

Visibility is the intersection of community membership, channel membership, post state, and moderation state. A raw community_id join leaks private and deleted content.
