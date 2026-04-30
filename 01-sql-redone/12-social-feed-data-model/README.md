# Social Feed Data Model

Backend scenario: Ada opens a small social feed backed by users, posts, comments, reactions, reposts, follows, blocks, mutes, groups, and visibility rules.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/12-social-feed-data-model
```

## Rows To Inspect

- Ben posts 101 and 102 are visible to Ada through public and followers-only paths.
- Diya post 401 is visible through Backend Club membership.
- Cy post 201 and Noor post 301 are excluded because Ada muted/blocked their authors.
- Lina post 601 is a Design Club group post and Ada is not in Design Club.
- Maya, Cy, Noor, Ada, and Diya interact with Ben post 101 without changing Ben's author eligibility.

