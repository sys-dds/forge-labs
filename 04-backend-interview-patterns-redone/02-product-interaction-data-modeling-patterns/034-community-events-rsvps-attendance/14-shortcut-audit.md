# Shortcut Audit

## Likely shortcut

Counting every RSVP as attendance or capacity.

## How base proof catches it

Cy non-member, Diya declined, Eli waitlisted, and cancelled event 2002 all break the shortcut.

## How variant proof catches it

The variant proof catches role, access, visibility, RSVP, or moderation shortcuts by changing real rows while keeping the same verification query. Eli is promoted to going in the variant, changing capacity and promotion contracts.

## What mutation should fail

Change event 2002 to scheduled; cancelled_event_hidden should flip.

## What learner should inspect manually

Inspect `bip_pim_034` seed rows, especially event 2001, event 2002, RSVP 3003, RSVP 3004, waitlist row 4005, attendance 5001.
