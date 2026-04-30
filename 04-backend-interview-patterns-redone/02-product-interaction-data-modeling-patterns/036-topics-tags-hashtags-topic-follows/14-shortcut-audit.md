# Shortcut Audit

## Likely shortcut

Raw hashtag text matching without normalized topics or visibility joins.

## How base proof catches it

Base data has hashtag 301, follow 5001, deleted post 1002, blocked creator 202, and downrank treatment 7001.

## How variant proof catches it

Variant pauses Ada follow 5001 and adds Ben follow 5002, changing the followed content outcome for Ada.

## What mutation should fail

Change post 1002 from deleted to active; deleted_content_hidden must fail.

## What learner should inspect manually

Inspect `bip_pim_036` rows, especially hashtag 301, follow 5001, block 6001, post 1002, and treatment 7001.
