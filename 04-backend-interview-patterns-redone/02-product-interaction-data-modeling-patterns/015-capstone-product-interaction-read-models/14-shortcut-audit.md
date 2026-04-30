# Shortcut Audit

## Likely shortcut

Return one raw joined view that trusts counters and ignores visibility, controls, repost lifecycle, and private saves.

## How base proof catches it

The base proof checks Ada viewer 1 sees Ben profile 2 but not Omar profile 4 blocked, sees Ben public post 501 but not Cy close-friends post 502 unless in group, hide 901 suppresses post 503, mute 1->5 suppresses Eli post 504, repost 701 points to Ben post 501, Ada bookmark 801 is private, post 501 source counts are 2 likes and 1 comment while stored likes are 3, Ben follower source is 2 while stored is 1, and Ada unread count is 2.

## How variant proof catches it

The variant adds Ada to Cy close friends, removes the hide, repairs post likes, and adds an unread notification, changing several contracts with the same query.

## What mutation should fail

Remove block, group membership, hide, mute, read-model drift, or private bookmark predicates.

## What learner should inspect manually

Inspect `users, profiles, posts, post_reactions, comments, friendships, audience_groups, audience_group_members, block_edges, hide_events, mute_edges, report_events, reposts, bookmarks, notifications, post_count_read_models, user_count_read_models` and compare the base and variant expected CSV contracts.
