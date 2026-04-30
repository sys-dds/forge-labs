# Scaling Notes

Stay small in the interview: index foreign keys, keep lifecycle rows explicit, and make the read contract deterministic.

- Keep each source table narrow and indexed by community_id.
- Promote read models only after the source contract is correct.
- Use audit rows to debug product state before adding infrastructure.

Avoid jumping to infrastructure or realtime platform concerns for this clinic.
