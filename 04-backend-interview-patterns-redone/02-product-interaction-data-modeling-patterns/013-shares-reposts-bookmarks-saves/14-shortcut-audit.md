# Shortcut Audit

## Likely shortcut

Treat reposts as standalone public posts and count all bookmark history rows.

## How base proof catches it

The base proof checks repost 301 points to Ben original post 201, quote repost 401 has Ada text plus original 201, Ada bookmark history rows 501 and 502 should count once, Cy cannot see Ada private save, deleted original 202 suppresses repost 302, and Omar original 203 is blocked for Ada so repost 303 is suppressed.

## How variant proof catches it

The variant restores deleted original 202 and removes Ada duplicate bookmark history, changing share count and save evidence.

## What mutation should fail

Remove original deleted filtering, block suppression, or bookmark deduplication.

## What learner should inspect manually

Inspect `users, posts, reposts, quote_reposts, bookmarks, block_edges` and compare the base and variant CSV contracts.
