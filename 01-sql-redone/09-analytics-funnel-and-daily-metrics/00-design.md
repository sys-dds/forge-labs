# Design

## What this clinic teaches

Funnel metrics need user-level grain, internal-user filtering, deduped signups, and event ordering after signup.

## Named rows and why each exists

- Ada proves same-day signup, feed view, and post conversion.
- Ben proves feed-after-signup without posting.
- Cy proves duplicate signup events must count once.
- Diya proves feed views without signup are not funnel progress.
- Noor proves internal users must be filtered early.
- Maya proves next-day post conversion is separate from same-day conversion.
- Omar proves a signup date can have zero downstream metrics.

## Broken query bug

The broken query counts raw events by event date, includes Noor, counts Diya's feed view, counts Cy twice, and mixes same-day and next-day post conversion.

## Exact wrong result from the broken query

For 2026-01-01 the broken query reports 6 signup users, 4 feed-view users, and 2 same-day post users. It also fails to report Maya as a next-day post conversion tied to her signup date.

## Correct result from the solution

2026-01-01 has signup_users 4, feed_view_after_signup_users 2, same_day_post_after_signup_users 1, and next_day_post_after_signup_users 1. 2026-01-02 has signup_users 1 and zero downstream metrics.

## Proof assertions

The proof checks exact daily rows, Cy counted once, Noor excluded, Diya not counted after signup, Ada same-day post, and Maya next-day post.

## What the learner should notice

The event table is event grain; the dashboard is signup-user grain by signup date.

## Interview explanation target

Explain funnel grain, deduplication, event order, internal/test filtering, and date bucket behavior.

## Row removal checks

- Wrong behavior if removed: without Ada, same-day conversion is not tested.
- Wrong behavior if removed: without Ben, feed-without-post conversion is not tested.
- Wrong behavior if removed: without Cy, duplicate signup dedupe is not tested.
- Wrong behavior if removed: without Diya, feed-without-signup pollution is not tested.
- Wrong behavior if removed: without Maya, next-day post conversion is not tested.
