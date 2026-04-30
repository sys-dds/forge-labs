# Shortcut Audit

## Likely shortcut

Selecting every community_posts row for the community.

## How base proof catches it

Cy cannot see private post 1002, Diya removed cannot see anything, and deleted post 1004 is hidden.

## How variant proof catches it

The variant proof catches role, access, visibility, RSVP, or moderation shortcuts by changing real rows while keeping the same verification query. Cy gets a channel_memberships row in the variant, so the private channel visibility contract changes.

## What mutation should fail

Delete channel membership 5002; private_channel_member_visible should become false.

## What learner should inspect manually

Inspect `bip_pim_033` seed rows, especially channel 202, channel membership 5002, post 1004, moderation action 7001, thread 6001.
