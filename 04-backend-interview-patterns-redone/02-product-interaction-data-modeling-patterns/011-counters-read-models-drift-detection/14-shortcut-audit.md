# Shortcut Audit

## Likely shortcut

Trust stored counters without recalculating from source tables.

## How base proof catches it

The base proof checks post 101 has two active likes but stored like_count 3, post 101 has one live comment and stored comment_count 1, Ben user 2 has two active followers but stored follower_count 1, Ada user 1 has two unread notifications and stored unread_count 2.

## How variant proof catches it

The variant repairs the post like counter and changes Ada unread stored count, so drift moves from post likes to notifications.

## What mutation should fail

Remove the source-count CTEs or compare only one counter family.

## What learner should inspect manually

Inspect `users, posts, post_reactions, comments, follow_edges, notifications, post_count_read_models, user_count_read_models, notification_count_read_models` and compare `06-expected-output.csv` with `06b-expected-output-variant.csv`.
