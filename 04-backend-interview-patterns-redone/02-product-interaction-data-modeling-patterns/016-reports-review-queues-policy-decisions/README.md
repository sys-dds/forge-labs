# 016 Reports Review Queues Policy Decisions

Design reports, review queues, policy decisions, and treatment rows for unsafe product content.

Schema `bip_pim_016` uses named safety rows: reports 1001 and 1002 both target post 201 and group into queue item 3001, report 1003 on post 202 is low quality and allowed in decision 4002, evidence rows 2001 and 2002 link to spam decision 4001, and treatment 5001 hides post 201.

Run `./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/016-reports-review-queues-policy-decisions`.
