# Data Model

## Actual tables

`users, profiles, posts, post_reactions, comments, friendships, audience_groups, audience_group_members, block_edges, hide_events, mute_edges, report_events, reposts, bookmarks, notifications, post_count_read_models, user_count_read_models`.

## Trap rows

Ada viewer 1 sees Ben profile 2 but not Omar profile 4 blocked, sees Ben public post 501 but not Cy close-friends post 502 unless in group, hide 901 suppresses post 503, mute 1->5 suppresses Eli post 504, repost 701 points to Ben post 501, Ada bookmark 801 is private, post 501 source counts are 2 likes and 1 comment while stored likes are 3, Ben follower source is 2 while stored is 1, and Ada unread count is 2.

## Constraints

Source tables define truth, read models are display state, visibility and controls are viewer-specific, and share/save lifecycle rows are not ordinary public posts.

## Read contract

Compose visibility, controls, share/save, source counts, read-model counts, unread counts, drift rows, and repair candidates from source tables instead of returning a raw join.
