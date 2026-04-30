# Shortcut Audit

## Likely shortcut

Return a raw joined view across users, posts, notifications, and activity.

## How base proof catches it

Base proof checks Ada sees Ben/Diya/Eli profiles, not Cy who blocked Ada or inactive Fay; home feed has Ben post 1001, variant also Eli post 1003; post 1001 counts only live reactions/comments; Ada/Diya match 5001 is active; unread notifications change from two to three.

## How variant proof catches it

The variant changes post counts, notification count, home feed, activity feed, and recommendation output while the same query runs.

## What mutation should fail

Remove one deleted-row, block, follow, unread, match, or recommendation exclusion filter.

## What learner should inspect manually

Inspect the named tables and compare each capstone contract row in both expected CSV files.
