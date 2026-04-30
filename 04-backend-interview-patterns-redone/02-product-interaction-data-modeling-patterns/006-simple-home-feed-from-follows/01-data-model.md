# Data Model

## Actual tables

`users, follow_edges, block_edges, mute_edges, posts, feed_seen_events`.

## Trap rows

Ada should see Ben post 101 and Cy posts 108/102, but not Eli 103 when unfollowed, Omar 104 blocked, Noor 105 muted, Ben 106 deleted, or Lina 107 inactive.

## Constraints

`follow_edges.state` must be active, `users.status` must be active, `posts.deleted_at` must be null, and block/mute rows suppress followed authors.

## Read contract

Join active follow_edges from viewer 1 to active authors, anti-join block_edges and mute_edges, filter deleted posts, and order by created_at desc then post_id desc for a stable cursor.
