# Data Model

## Actual tables

`users, posts, post_reactions, comments, follow_edges, notifications, post_count_read_models, user_count_read_models, notification_count_read_models`.

## Trap rows

post 101 has two active likes but stored like_count 3, post 101 has one live comment and stored comment_count 1, Ben user 2 has two active followers but stored follower_count 1, Ada user 1 has two unread notifications and stored unread_count 2.

## Constraints

Read-model counters are display caches; post_reactions.deleted_at, comments.deleted_at, follow_edges.state, and notifications.state define source truth. The verification query derives the contract from source rows and read-model rows rather than expected-output literals.

## Read contract

Compute source counts from source tables, join read-model rows, emit count rows, drift rows, no-drift rows, and repair candidates based on source minus stored values.
