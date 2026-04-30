# Shortcut Audit

## Likely shortcut

Granting access to anyone with a community_join_requests or community_invites row.

## How base proof catches it

Ada pending request 2001, Cy rejected request 2003, Diya expired invite 4004, and Eli banned invite 4005 all disagree with request-or-invite access.

## How variant proof catches it

The variant proof catches role, access, visibility, RSVP, or moderation shortcuts by changing real rows while keeping the same verification query. Invite 4004 becomes accepted and unexpired with membership 3004, so an expiry-hard-coded answer fails.

## What mutation should fail

Set request 2003 to approved without membership; rejected_request_hidden should still depend on active membership.

## What learner should inspect manually

Inspect `bip_pim_032` seed rows, especially request 2001, request 2003, invite 4004, ban 5005, audit rows 6002 and 6006.
