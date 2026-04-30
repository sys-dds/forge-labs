# Shortcut Audit

## Likely shortcut

Returning all saved_items for a user as if they were one folder.

## How base proof catches it

Base rows include private collection 3001, public collection 3002, duplicate item 5003, deleted post 1002, blocked author item 5004, and collaborator Diya row 4001.

## How variant proof catches it

Variant makes collection 3001 public and reorders item 5002 before 5001, changing visibility and order contracts.

## What mutation should fail

Set item 5003 to active; duplicate_item_prevented must fail.

## What learner should inspect manually

Inspect `bip_pim_039` rows, especially collection 3001, member 4001, items 5001-5005, block 7001, and treatment 8001.
