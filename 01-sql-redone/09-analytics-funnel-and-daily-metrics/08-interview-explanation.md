# Interview Explanation

## Direct answer

I would convert raw events into one signup row per non-internal user, then count later funnel steps with `EXISTS` predicates tied to that user's signup time and signup date.

## Dataset walkthrough

Ada completes signup, feed view, and same-day post. Ben signs up and views feed. Cy signs up twice but counts once. Diya views feed without signup. Noor is internal. Maya signs up on January 1 and posts on January 2. Omar signs up on January 2 with no later events.

## Query reasoning

The query filters internal users first, deduplicates signups with `MIN(event_at)`, builds a user-level funnel row, and aggregates by signup date. Feed and post steps require `event_at >= signup_at`.

## Common mistake

The common mistake is grouping raw events by event date. That counts Cy twice, includes Noor, and treats Diya's feed view as funnel progress.

## Senior trade-off

The `EXISTS` shape is explicit and keeps the metric grain clear. For very large event tables, I would still keep the same semantics and consider summary tables later.

## Follow-up answer

If product added more steps, I would add user-level step flags first, then aggregate. I would not count raw event rows unless the metric name explicitly asked for event volume.

