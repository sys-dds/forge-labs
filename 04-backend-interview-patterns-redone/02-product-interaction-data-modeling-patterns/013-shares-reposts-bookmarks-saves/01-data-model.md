# Data Model

## Actual tables

`users, posts, reposts, quote_reposts, bookmarks, block_edges`.

## Trap rows

repost 301 points to Ben original post 201, quote repost 401 has Ada text plus original 201, Ada bookmark history rows 501 and 502 should count once, Cy cannot see Ada private save, deleted original 202 suppresses repost 302, and Omar original 203 is blocked for Ada so repost 303 is suppressed.

## Constraints

Reposts reference originals, bookmarks are private user state, active rows count only when deleted_at is null, and original author blocks suppress shared content.

## Read contract

Join repost and quote rows to original posts and block_edges for viewer 1, dedupe active bookmarks by user/content, and emit share/save visibility and count contracts.
