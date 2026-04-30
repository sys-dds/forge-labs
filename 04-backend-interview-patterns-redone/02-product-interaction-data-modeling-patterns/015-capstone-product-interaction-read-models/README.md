# 015 Capstone Product Interaction Read Models

Design a small product interaction model that combines source tables, visibility, user controls, counters, read models, shares, saves, and drift detection.

Schema `bip_pim_015` trap rows: Ada viewer 1 sees Ben profile 2 but not Omar profile 4 blocked, sees Ben public post 501 but not Cy close-friends post 502 unless in group, hide 901 suppresses post 503, mute 1->5 suppresses Eli post 504, repost 701 points to Ben post 501, Ada bookmark 801 is private, post 501 source counts are 2 likes and 1 comment while stored likes are 3, Ben follower source is 2 while stored is 1, and Ada unread count is 2.

Run `./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/015-capstone-product-interaction-read-models`.
