# 011 Counters Read Models Drift Detection

Design counters and read models for likes, comments, followers, and unread notifications without losing source-of-truth correctness.

Schema `bip_pim_011` uses concrete trap rows: post 101 has two active likes but stored like_count 3, post 101 has one live comment and stored comment_count 1, Ben user 2 has two active followers but stored follower_count 1, Ada user 1 has two unread notifications and stored unread_count 2.

Run `./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/011-counters-read-models-drift-detection`.
