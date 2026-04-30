# Read/Write Path

## Write path

- Create community 101 and active memberships for Ada and Ben.
- Assign owner and moderator roles with permission rows.
- Record Cy pending request 3003 and Diya banned invite 4004.
- Insert public/private channel posts, thread 8501, moderation action 10003, event 9001, waitlist 9305, attendance 9401, and community_audit_log rows.

## Read path

- Compose active membership, ban suppression, role permission, private access, channel membership, visible post, moderation, RSVP, waitlist, attendance, and audit trace CTEs.
- Emit ten contract rows from real relationships.
- Use the same query for base and variant datasets.

The verification query is intentionally a read contract over stored rows.
