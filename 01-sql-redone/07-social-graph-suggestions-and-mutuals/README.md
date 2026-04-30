# Social Graph Suggestions And Mutuals

Backend scenario: Ada opens "People you may know." Reachable users are not automatically safe suggestions.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/07-social-graph-suggestions-and-mutuals
```

## Rows To Inspect

- Ada follows Ben, Cy, and Maya.
- Ben follows Ada and Diya, making Ben the only mutual follow and one path to Diya.
- Cy follows Diya and Noor, making Diya duplicated and Noor reachable.
- Ada blocks Noor, so Noor must not be suggested.
- Omar follows Ada, but Ada does not follow Omar; incoming reachability is not a suggestion path.
- Theo has no edge and must remain absent.

