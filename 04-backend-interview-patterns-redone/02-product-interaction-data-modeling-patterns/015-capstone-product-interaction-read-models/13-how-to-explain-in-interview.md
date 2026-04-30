# How To Explain In Interview

## Direct answer

Use `users, profiles, posts, post_reactions, comments, friendships, audience_groups, audience_group_members, block_edges, hide_events, mute_edges, report_events, reposts, bookmarks, notifications, post_count_read_models, user_count_read_models` to compose explicit read contracts and drift checks rather than one raw joined product view.

## Actual tables

Use `users, profiles, posts, post_reactions, comments, friendships, audience_groups, audience_group_members, block_edges, hide_events, mute_edges, report_events, reposts, bookmarks, notifications, post_count_read_models, user_count_read_models` in schema `bip_pim_015`.

## Actual trap rows

Ada viewer 1 sees Ben profile 2 but not Omar profile 4 blocked, sees Ben public post 501 but not Cy close-friends post 502 unless in group, hide 901 suppresses post 503, mute 1->5 suppresses Eli post 504, repost 701 points to Ben post 501, Ada bookmark 801 is private, post 501 source counts are 2 likes and 1 comment while stored likes are 3, Ben follower source is 2 while stored is 1, and Ada unread count is 2.

## Exact query mechanics

Compose visibility, controls, share/save, source counts, read-model counts, unread counts, drift rows, and repair candidates from source tables instead of returning a raw join.

## Write path

Write source rows first, update read models separately, and compare them during verification or repair.

## Scaling follow-up

Materialize only after the source contract is stable and testable.
