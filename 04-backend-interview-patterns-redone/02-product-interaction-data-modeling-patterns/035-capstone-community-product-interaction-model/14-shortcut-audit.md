# Shortcut Audit

## Likely shortcut

A raw joined community view that ignores lifecycle and visibility filters.

## How base proof catches it

Cy pending, Diya banned, post 8003 removed, private post 8002, and Eli waitlisted all defeat a raw join.

## How variant proof catches it

The variant proof catches role, access, visibility, RSVP, or moderation shortcuts by changing real rows while keeping the same verification query. Ben gains transfer_ownership and Eli is promoted to going, changing at least two contracts.

## What mutation should fail

Remove audit row 11003; moderation_audit_contract and debug trace should fail.

## What learner should inspect manually

Inspect `bip_pim_035` seed rows, especially membership 2002, request 3003, invite 4004, ban 5004, post 8003, event 9001, waitlist 9305, audit 11003.
