# How To Explain In Interview

## Direct answer

Model reports as evidence rows that create queue work, then record reviewed policy decisions and treatments separately.

## Actual tables

Use `users, posts, comments, report_events, report_evidence, review_queue_items, policy_decisions, policy_treatments, moderators` in schema `bip_pim_016`.

## Actual trap rows

reports 1001 and 1002 both target post 201 and group into queue item 3001, report 1003 on post 202 is low quality and allowed in decision 4002, evidence rows 2001 and 2002 link to spam decision 4001, and treatment 5001 hides post 201.

## Exact query mechanics

Group report_events into review_queue_items, join evidence to policy_decisions, join treatments to decisions, and emit queue, decision, treatment, allowed, and evidence-link contracts.

## Write path

Append report_events and report_evidence, upsert a grouped review_queue_items row, then write moderator policy_decisions and policy_treatments.

## Moderation/safety follow-up

Ask which evidence rows justified the decision and whether low-quality reports should remain allowed until reviewed.

## Scaling follow-up

Queue derivation can be materialized, but the evidence to decision to treatment lineage must stay queryable.
