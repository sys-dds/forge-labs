# Public Profile Projection And Privacy

Backend scenario: Ada opens Ben's public profile and uses profile discovery. The backend must return a safe projection, not raw user/profile rows.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/06-public-profile-projection-and-privacy
```

## Rows To Inspect

- Ben has `ben-private@example.test`, two visible posts, one hidden post, two followers, and one following edge.
- Cy has `is_searchable = false`, so Cy must not appear in public search.
- Diya is searchable with zero posts, so Diya must still appear in discovery.
- Noor is searchable, but Ada blocked Noor, so Ada-safe search must exclude Noor.
- Maya follows Ben and interacts with Ben's posts, creating count pressure without changing the profile projection.

