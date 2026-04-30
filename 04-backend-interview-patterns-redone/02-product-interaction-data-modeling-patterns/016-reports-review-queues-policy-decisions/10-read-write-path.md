# Read/Write Path

## Write path

Append report_events and report_evidence, upsert a grouped review_queue_items row, then write moderator policy_decisions and policy_treatments.

## Read path

Group report_events into review_queue_items, join evidence to policy_decisions, join treatments to decisions, and emit queue, decision, treatment, allowed, and evidence-link contracts.
