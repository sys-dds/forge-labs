# How To Explain In Interview

## Direct answer

Keep original content separate from repost objects and treat saves as private user state.

## Actual tables

Use `users, posts, reposts, quote_reposts, bookmarks, block_edges` in schema `bip_pim_013`.

## Actual trap rows

repost 301 points to Ben original post 201, quote repost 401 has Ada text plus original 201, Ada bookmark history rows 501 and 502 should count once, Cy cannot see Ada private save, deleted original 202 suppresses repost 302, and Omar original 203 is blocked for Ada so repost 303 is suppressed.

## Exact query mechanics

Join repost and quote rows to original posts and block_edges for viewer 1, dedupe active bookmarks by user/content, and emit share/save visibility and count contracts.

## Write path

Write reposts and quote_reposts as separate objects pointing at posts; write bookmarks as user/content state with lifecycle timestamps.

## Scaling follow-up

Share and save counters can be materialized later, but original content lifecycle and private save visibility remain source-derived.
