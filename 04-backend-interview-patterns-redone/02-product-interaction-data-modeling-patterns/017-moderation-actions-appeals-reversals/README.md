# 017 Moderation Actions Appeals Reversals

Design moderation actions, appeals, reversals, and audit lineage.

Schema `bip_pim_017` uses named safety rows: post 201 is removed by action 601 and appeal 701 is pending, post 202 is restored by approved appeal 702 and audit row 9002, post 203 stays removed after rejected appeal 703, and moderator 10 plus operator 11 are traceable.

Run `./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/017-moderation-actions-appeals-reversals`.
