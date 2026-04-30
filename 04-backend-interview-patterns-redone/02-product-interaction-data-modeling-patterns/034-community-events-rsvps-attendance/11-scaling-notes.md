# Scaling Notes

Stay small in the interview: index foreign keys, keep lifecycle rows explicit, and make the read contract deterministic.

- Index event_rsvps(event_id,user_id,state).
- Use capacity checks transactionally in writes, not in read contracts.
- Keep event_audit_log append-only for promotion/cancellation trace.

Avoid jumping to infrastructure or realtime platform concerns for this clinic.
