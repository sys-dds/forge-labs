# Interview Explanation

## Direct answer

I would treat home timelines and notification inboxes as read models: useful for fast reads, but still protected by read-time safety filters, dedupe keys, and read markers.

## Dataset walkthrough

Ada's timeline table contains Ben 101, Cy 201, and Noor 301. Only Ben survives because Cy is muted and Noor is blocked. Ada's inbox has Ben comment, Diya like, two Maya mention rows with one source_event_id, and Lina's older read mention.

## Query reasoning

The timeline view joins timeline items to posts and authors, then applies Ada's mute and block filters. The inbox view dedupes by source_event_id. The unread count reads the deduped inbox and filters `read_at IS NULL`.

## Common mistake

The common mistake is assuming fanout rows are always safe forever. If Ada mutes Cy after fanout, Cy 201 must still be filtered or suppressed at read time.

## Senior trade-off

Fanout-on-write makes reads fast but can go stale. Fanout-on-read is fresher but heavier. A hybrid keeps simple rows in timeline tables and queries dynamic cases later.

## Follow-up answer

This prepares for later Redis, Kafka, and PostgreSQL-specific paths by naming the read-model tables and correctness rules without implementing distributed fanout here.

