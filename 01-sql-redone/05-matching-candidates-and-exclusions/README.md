# Matching Candidates And Exclusions

Backend scenario: Ada opens matching candidates. The system must remove unsafe or impossible candidates before preference fit or ranking.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/05-matching-candidates-and-exclusions
```

## Rows To Inspect

- Ben is active and mutually liked with Ada, so Ben is a match and not a candidate.
- Cy liked Ada, but Ada passed Cy; PASS must not become a match.
- Diya is active but blocked by Ada, so Diya cannot be rescued by preference fit.
- Noor is inactive and must not be a candidate.
- Maya is active, unswiped, in Ada's city and age range, and shares 2 interests.
- Omar is active and unswiped, so Omar is a raw candidate, but he is outside Ada's preference fit.

