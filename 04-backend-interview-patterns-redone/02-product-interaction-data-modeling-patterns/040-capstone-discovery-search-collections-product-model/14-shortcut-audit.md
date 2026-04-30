# Shortcut Audit

## Likely shortcut

A globally popular visible feed that ignores topic follows, filters, facets, saved search state, trend components, suppression, and collection visibility.

## How base proof catches it

Base rows include follow 5001, filter 9101, paused saved search 9202, treatment 16001, private collection 12001, and duplicate item 13003.

## How variant proof catches it

Variant resumes saved search 9202 and changes topic 102 treatment from hide to review, changing at least two contracts.

## What mutation should fail

Change collection item 13003 to active; collection_item_lifecycle_contract must change.

## What learner should inspect manually

Inspect `bip_pim_040` rows, especially hashtag 301, follow 5001, query 9001, filter 9101, saved search 9202, treatment 16001, collection 12001, and item 13003.
