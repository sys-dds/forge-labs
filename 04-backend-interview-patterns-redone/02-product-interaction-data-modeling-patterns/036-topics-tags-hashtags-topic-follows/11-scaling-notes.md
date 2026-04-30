# Scaling Notes

Stay small in this interview slice: model the source rows first, then discuss indexes and read models after correctness.

- Index content_topic_links(topic_id,content_id).
- Index user_topic_follows(user_id,topic_id,follow_state).
- Keep treatment rows auditable instead of burying them in one field.

Avoid platform infrastructure detours for this clinic.
