# 006 Simple Home Feed From Follows

Design a simple home feed from people a user follows. Schema `bip_pim_006` proves visible, hidden, ordering, and cursor rows with base and variant datasets.

Trap rows: Ada should see Ben post 101 and Cy posts 108/102, but not Eli 103 when unfollowed, Omar 104 blocked, Noor 105 muted, Ben 106 deleted, or Lina 107 inactive.

Run `./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/006-simple-home-feed-from-follows`.
