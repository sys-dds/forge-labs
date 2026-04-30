# How To Explain In Interview

## Direct answer

Use community_events for the event, event_rsvps for intent and lifecycle, event_waitlist for ordering, event_attendance for check-in, and event_audit_log for cancellation or promotion trace.

## Actual tables

- `users`
- `communities`
- `community_memberships`
- `community_events`
- `event_rsvps`
- `event_waitlist`
- `event_attendance`
- `event_audit_log`

## Actual trap rows

- Ada user 1 has going RSVP 3001 for event 2001.
- Cy user 3 is not a member and RSVP 3003 must be denied.
- Diya user 4 declined RSVP 3004 and does not count.
- Eli user 5 has waitlisted RSVP 3005 and waitlist row 4005.
- Cancelled event 2002 must be hidden from upcoming contracts.

## Exact query mechanics

The query derives eligible_rsvps, going_counts, upcoming_events, and attendance_validity before emitting waitlisted_not_going and waitlist_promotion_contract.

## Write path

Create scheduled event 2001 with capacity 2 and cancelled event 2002. Insert going, maybe, declined, and waitlisted event_rsvps. Insert waitlist row 4005 and audit row 6001 for promotion. Insert attendance 5001 linked to Ada going RSVP 3001.

## Community/product follow-up

You can answer product questions like who can RSVP, who is waitlisted, who checked in, and why someone was promoted.

## Scaling follow-up

At scale, enforce capacity with transactional writes, but keep query contracts understandable from source tables.
