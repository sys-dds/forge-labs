# How To Explain In Interview

## Direct answer

Use `users, profiles, follow_edges, block_edges, posts, post_reactions, comments, swipe_events, matches, notifications, activity_events, user_interests, post_tags` and compose eight small read contracts instead of one giant social-network design.

## Actual tables

Use `users, profiles, follow_edges, block_edges, posts, post_reactions, comments, swipe_events, matches, notifications, activity_events, user_interests, post_tags` in schema `bip_pim_010`.

## Actual trap rows

Ada sees Ben/Diya/Eli profiles, not Cy who blocked Ada or inactive Fay; home feed has Ben post 1001, variant also Eli post 1003; post 1001 counts only live reactions/comments; Ada/Diya match 5001 is active; unread notifications change from two to three.

## Exact query mechanics

Compose small contracts: profile visibility uses profiles/follows/blocks; counts ignore deleted rows; match uses canonical active matches; notifications count unread; activity and home feed filter deleted, blocked, inactive, and followed state; recommendation candidates use shared interests with exclusions.

## Write path

Write each object, relationship, and event separately; derive profile, counts, match, notification, activity, feed, and recommendation contracts from them.

## Scaling follow-up

Only after the contracts pass should you discuss materialized counters, feed tables, or async jobs.
