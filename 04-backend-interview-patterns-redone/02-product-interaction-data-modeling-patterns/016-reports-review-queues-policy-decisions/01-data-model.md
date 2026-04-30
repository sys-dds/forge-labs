# Data Model

## Actual tables

`users, posts, comments, report_events, report_evidence, review_queue_items, policy_decisions, policy_treatments, moderators`.

## Trap rows

reports 1001 and 1002 both target post 201 and group into queue item 3001, report 1003 on post 202 is low quality and allowed in decision 4002, evidence rows 2001 and 2002 link to spam decision 4001, and treatment 5001 hides post 201.

## Constraints

Reports are evidence, not automatic removals; queue priority derives from severity and evidence count; decisions and treatments are separate rows. The verification query derives safety outcomes from evidence, decisions, treatments, components, and audit rows.

## Read contract

Group report_events into review_queue_items, join evidence to policy_decisions, join treatments to decisions, and emit queue, decision, treatment, allowed, and evidence-link contracts.
