# Shortcut Audit

## Likely shortcut

Remove content whenever a report exists and skip evidence or review state.

## How base proof catches it

The base proof checks reports 1001 and 1002 both target post 201 and group into queue item 3001, report 1003 on post 202 is low quality and allowed in decision 4002, evidence rows 2001 and 2002 link to spam decision 4001, and treatment 5001 hides post 201.

## How variant proof catches it

The variant adds credible evidence for post 202, changing safe_content_allowed from allowed to hidden treatment.

## What mutation should fail

Remove the decision join or use raw report count as treatment truth.

## What learner should inspect manually

Inspect `users, posts, comments, report_events, report_evidence, review_queue_items, policy_decisions, policy_treatments, moderators` and compare `06-expected-output.csv` with `06b-expected-output-variant.csv`.
