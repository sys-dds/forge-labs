# SQL Endpoint Capstone

Backend scenario: Ada opens a creator discovery endpoint. The query should return suggested creators, not raw users.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/10-sql-endpoint-capstone
```

## Rows To Inspect

- Ada follows Ben; Ben is already followed and must not be returned.
- Ben follows Diya, Maya, and Lina, creating Ada's second-degree creator candidates.
- Cy is blocked by Ada and must not be returned even though Cy has visible posts.
- Noor is private/non-searchable and must not be returned.
- Omar is public but has only hidden posts, so Omar has no visible signal.
- Theo is disconnected and must not appear.
- Diya, Lina, and Maya are valid creator suggestions with exact counts and stable cursor fields.

