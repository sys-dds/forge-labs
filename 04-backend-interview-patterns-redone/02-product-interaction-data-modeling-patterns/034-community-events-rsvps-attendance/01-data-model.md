# Data Model

## Actual tables

- `users`
- `communities`
- `community_memberships`
- `community_events`
- `event_rsvps`
- `event_waitlist`
- `event_attendance`
- `event_audit_log`

## Constraints

- Only active members can RSVP to member-only private community events.
- Declined and waitlisted RSVPs do not count as going capacity.
- Cancelled events are suppressed from upcoming lists.
- Attendance check-ins link to going RSVPs.
- Waitlist promotion is represented by audit rows and RSVP state changes.

## Trap rows

- Ada user 1 has going RSVP 3001 for event 2001.
- Cy user 3 is not a member and RSVP 3003 must be denied.
- Diya user 4 declined RSVP 3004 and does not count.
- Eli user 5 has waitlisted RSVP 3005 and waitlist row 4005.
- Cancelled event 2002 must be hidden from upcoming contracts.

## Why this shape

Events need both intent rows and attendance rows. RSVP state controls capacity; attendance proves check-in after a valid going RSVP.
