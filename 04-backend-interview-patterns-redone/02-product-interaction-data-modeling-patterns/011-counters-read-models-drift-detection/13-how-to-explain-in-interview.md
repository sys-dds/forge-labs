# How To Explain In Interview

## Direct answer

Use source tables for truth and read-model tables for fast display, then add drift checks that compare both layers.

## Actual tables

Use `users, posts, post_reactions, comments, follow_edges, notifications, post_count_read_models, user_count_read_models, notification_count_read_models` in schema `bip_pim_011`.

## Actual trap rows

post 101 has two active likes but stored like_count 3, post 101 has one live comment and stored comment_count 1, Ben user 2 has two active followers but stored follower_count 1, Ada user 1 has two unread notifications and stored unread_count 2.

## Exact query mechanics

Compute source counts from source tables, join read-model rows, emit count rows, drift rows, no-drift rows, and repair candidates based on source minus stored values.

## Write path

Write source interactions first, then update count read models; repair jobs compare read models against source counts.

## Scaling follow-up

Counters may be incrementally maintained, but source tables remain the correctness layer for audits and repairs.
