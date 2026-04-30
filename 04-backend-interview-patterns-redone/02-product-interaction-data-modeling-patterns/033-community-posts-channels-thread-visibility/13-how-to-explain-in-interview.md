# How To Explain In Interview

## Direct answer

Model channels and posts separately, keep channel membership for private rooms, attach replies through community_threads, and filter by membership state plus post moderation state.

## Actual tables

- `users`
- `communities`
- `community_memberships`
- `community_channels`
- `channel_memberships`
- `community_posts`
- `community_threads`
- `community_post_moderation_actions`

## Actual trap rows

- Ada user 1 is active and sees public post 1001.
- Ben user 2 is channel member 5002 and sees private post 1002.
- Cy user 3 is active but not in channel 202 and must not see post 1002.
- Diya user 4 has removed membership 3004 and must see no posts.
- Post 1004 is deleted and post 1005 is removed by moderation action 7001.

## Exact query mechanics

The query builds active_viewers and visible_posts CTEs with channel visibility and moderation filters, then emits pinned_post_contract, thread_reply_contract, and channel_visibility_trace.

## Write path

Create public channel 201 and private channel 202. Insert channel_memberships for Ben but not Cy. Insert posts 1001 through 1005 with pinned, deleted, and removed states. Insert community_threads row 6001 linking reply 1003 to parent post 1001.

## Community/product follow-up

This lets a community have public announcements, private moderator channels, and thread replies without becoming a full forum clone.

## Scaling follow-up

Use read models for timelines later, but preserve source rows for visibility and moderation checks.
