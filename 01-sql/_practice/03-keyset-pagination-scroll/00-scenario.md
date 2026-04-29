# Scenario

Ada scrolls a feed. Page one loads, then a newer post arrives before Ada asks for page two.

Two existing posts share the exact same timestamp. That makes `created_at` alone too weak as a cursor because it cannot identify the last seen row when several rows have the same time. The query must order by `created_at DESC, id DESC` and carry both values in the cursor.

The backend question:

```text
How do we continue after the last seen row when new rows can arrive above the cursor?
```
