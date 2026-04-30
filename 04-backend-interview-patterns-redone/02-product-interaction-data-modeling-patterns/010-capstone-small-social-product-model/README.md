# 010 Capstone Small Social Product Model

Design a small social product model combining profiles, follows, likes, comments, swipes, matches, notifications, activity, recommendations, and a simple home feed. Schema `bip_pim_010`.

Trap rows: Ada sees Ben/Diya/Eli profiles, not Cy who blocked Ada or inactive Fay; home feed has Ben post 1001, variant also Eli post 1003; post 1001 counts only live reactions/comments; Ada/Diya match 5001 is active; unread notifications change from two to three.

Run `./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/010-capstone-small-social-product-model`.
