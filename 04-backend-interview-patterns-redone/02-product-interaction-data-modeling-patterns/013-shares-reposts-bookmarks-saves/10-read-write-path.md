# Read/Write Path

## Write path

Write reposts and quote_reposts as separate objects pointing at posts; write bookmarks as user/content state with lifecycle timestamps.

## Read path

Join repost and quote rows to original posts and block_edges for viewer 1, dedupe active bookmarks by user/content, and emit share/save visibility and count contracts.
