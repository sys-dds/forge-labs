# Scaling Notes

Stay small in the interview: index foreign keys, keep lifecycle rows explicit, and make the read contract deterministic.

- Index posts by community_id, channel_id, created_at.
- Index channel_memberships(channel_id,user_id).
- Keep moderation actions separate from physical deletes.

Avoid jumping to infrastructure or realtime platform concerns for this clinic.
