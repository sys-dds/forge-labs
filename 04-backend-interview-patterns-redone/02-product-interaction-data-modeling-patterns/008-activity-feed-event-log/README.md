# 008 Activity Feed Event Log

Design an activity feed/event log for user-visible activity. Schema `bip_pim_008`. Trap rows: Ada sees Ben public event 8001 and Diya followers event 8003, cannot see Ben private 8002; Ben sees his own private 8002; Cy is blocked from Ben event 8001; deleted post event 8004 is hidden.

Run `./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/008-activity-feed-event-log`.
