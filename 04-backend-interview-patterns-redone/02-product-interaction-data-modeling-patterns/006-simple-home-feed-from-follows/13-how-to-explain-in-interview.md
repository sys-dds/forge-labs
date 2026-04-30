# How To Explain In Interview

## Direct answer

Model a follow feed with `users, follow_edges, block_edges, mute_edges, posts, feed_seen_events` and prove the read contract against named rows.

## Actual tables

Use `users, follow_edges, block_edges, mute_edges, posts, feed_seen_events` in schema `bip_pim_006`.

## Actual trap rows

Ada should see Ben post 101 and Cy posts 108/102, but not Eli 103 when unfollowed, Omar 104 blocked, Noor 105 muted, Ben 106 deleted, or Lina 107 inactive.

## Exact query mechanics

Join active follow_edges from viewer 1 to active authors, anti-join block_edges and mute_edges, filter deleted posts, and order by created_at desc then post_id desc for a stable cursor.

## Write path

Create relationship rows and post rows separately; the feed read combines them.

## Scaling follow-up

A later materialized feed must still honor the same exclusions and cursor ordering.
