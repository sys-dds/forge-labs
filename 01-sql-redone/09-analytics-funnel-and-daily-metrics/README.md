# Analytics Funnel And Daily Metrics

Backend scenario: a dashboard reports signup to feed view to first post conversion. Raw event counts are wrong when events duplicate, internal users exist, and funnel steps do not respect user identity and time order.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/09-analytics-funnel-and-daily-metrics
```

## Rows To Inspect

- Ada signs up, views feed, and posts on 2026-01-01.
- Ben signs up and views feed on 2026-01-01 but does not post.
- Cy has duplicate signup events on 2026-01-01 and must count once.
- Diya views feed without signup and must not count in feed-after-signup.
- Noor is internal and must be excluded from all metrics.
- Maya signs up on 2026-01-01 and posts on 2026-01-02.
- Omar signs up on 2026-01-02 and does nothing else.

