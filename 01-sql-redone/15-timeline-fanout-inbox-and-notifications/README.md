# Timeline Fanout Inbox And Notifications

Backend scenario: a social product stores home timeline rows and notification inbox rows for fast reads.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/15-timeline-fanout-inbox-and-notifications
```

## Rows To Inspect

- Ben post 101 is in Ada's home timeline.
- Cy post 201 and Noor post 301 were incorrectly fanned out and must be filtered.
- Ben comment, Diya like, and Maya mention are unread notifications for Ada.
- Maya mention is duplicated with the same source_event_id.
- Lina has an older read notification that must not count unread.

