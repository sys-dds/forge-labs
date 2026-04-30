# Shortcut Audit

## Likely shortcut

A raw body/title text match that ignores filters, facets, saved-search state, and suppression.

## How base proof catches it

Base rows include filter 2001, paused saved search 4002, hidden listing 6001, deleted post 5003, and blocked creator 701.

## How variant proof catches it

Variant changes filter 2001 to listing and resumes saved search 4002, changing facet/result and alert outputs.

## What mutation should fail

Mark saved search 4002 active; paused_saved_search_no_alert must change.

## What learner should inspect manually

Inspect `bip_pim_037` rows, especially query 1001, filter 2001, facet 3001, saved search 4002, treatment 8001, and block 9001.
