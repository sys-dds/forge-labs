# Shortcut Audit

## Likely shortcut

Raw event count ordering with no window, decay, unique actor, or safety joins.

## How base proof catches it

Topic 102 has many events plus treatment 7001, while topic 103 has stale freshness component 4009.

## How variant proof catches it

Variant changes treatment 7001 from hide to review, so the spam topic is no longer suppressed by hide.

## What mutation should fail

Delete component 4002; unique_actor_component and component total must fail.

## What learner should inspect manually

Inspect `bip_pim_038` rows, especially window 3001, components 4001-4009, abuse signal 6001, treatment 7001, and snapshot 8001.
