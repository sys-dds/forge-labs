# Gauntlet Manifest Schema

Use one `key=value` per line.

Required keys:

```text
id=sql-gauntlet-feed-candidate-query-clinic
title=Feed Candidate Query Clinic
source_chapter=01-sql/05-joins-and-feed-candidates
difficulty=intermediate
concepts=joins, exclusions, row multiplication
dataset_entities=ada,ben,cy,noor,diya
bug_type=missing exclusions and row multiplication
broken_query_file=03-broken-query.sql
solution_file=04-solution.sql
proof_file=05-proof.tests.sql
expected_failure=muted or blocked author reaches feed candidates
expected_fix=apply NOT EXISTS exclusions before ranking inputs
estimated_time=25 minutes
what_to_break_next=remove mute predicate, join likes/comments directly
```

Keep values concrete. Mention the named row that should expose the bug.
