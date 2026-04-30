# Shortcut Audit

## Likely shortcut

Hard-code post ids 108, 102, and 101 or sort with a custom id case expression.

## How base proof catches it

Base proof checks Ada should see Ben post 101 and Cy posts 108/102, but not Eli 103 when unfollowed, Omar 104 blocked, Noor 105 muted, Ben 106 deleted, or Lina 107 inactive.

## How variant proof catches it

The variant makes Eli post 103 visible and changes `feed_order` without changing the query.

## What mutation should fail

Remove the mute or deleted-post filter. The CSV diff should show Noor 105 or Ben 106 leaking.

## What learner should inspect manually

Inspect `follow_edges`, `block_edges`, `mute_edges`, and `posts` beside both expected CSV files.
