# Read/Write Path

## Write path

Create posts in `posts`, update `follow_edges`, `block_edges`, and `mute_edges`, and optionally append `feed_seen_events` when a viewer consumes a row.

## Read path

Join active follow_edges from viewer 1 to active authors, anti-join block_edges and mute_edges, filter deleted posts, and order by created_at desc then post_id desc for a stable cursor.
