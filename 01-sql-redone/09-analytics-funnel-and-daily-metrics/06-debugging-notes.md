# Debugging Notes

Ada has signup 101, feed_view 102, and post_created 103 on 2026-01-01. Ada should count once in signup, feed-after-signup, and same-day post.

Ben has signup 201 and feed_view 202, but no post. Ben should count in feed-after-signup without inflating post conversion.

Cy has signup events 301 and 302. Counting events reports two signups for Cy, but the dashboard asks for signup users, so Cy counts once.

Diya has feed_view 401 without a signup. Diya's row should not enter the funnel because the previous step is missing.

Noor has signup 501, feed_view 502, and post_created 503, but Noor is internal. Filtering internal users after aggregation would already have polluted the counts.

Maya signs up on 2026-01-01 and posts on 2026-01-02. Maya is next-day conversion, not same-day conversion.

Omar signs up on 2026-01-02 and does nothing else. Omar proves the date bucket should show zero downstream metrics rather than disappear.

