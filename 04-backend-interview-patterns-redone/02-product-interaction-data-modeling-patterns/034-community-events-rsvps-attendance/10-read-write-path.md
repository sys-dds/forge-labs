# Read/Write Path

## Write path

- Create scheduled event 2001 with capacity 2 and cancelled event 2002.
- Insert going, maybe, declined, and waitlisted event_rsvps.
- Insert waitlist row 4005 and audit row 6001 for promotion.
- Insert attendance 5001 linked to Ada going RSVP 3001.

## Read path

- Require active membership before accepting member-only RSVP.
- Count only rsvp_state = going toward capacity.
- Suppress cancelled community_events in upcoming reads.
- Validate attendance by joining event_attendance to going event_rsvps.

The verification query is intentionally a read contract over stored rows.
