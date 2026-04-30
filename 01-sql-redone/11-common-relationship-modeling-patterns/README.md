# Common Relationship Modeling Patterns

Backend scenario: a learning platform connects students, teachers, classes, subjects, lessons, assignments, submissions, and attendance.

```bash
./scripts/forge-test-sql-redone.sh 01-sql-redone/11-common-relationship-modeling-patterns
```

## Rows To Inspect

- Ada and Ben are enrolled in Class 8A; Cy is enrolled in Class 8B.
- Sarah teaches Math to Class 8A, Omar teaches Science to Class 8A, and Sarah teaches English to Class 8B.
- Assignment 501 is Class 8A Math homework; Ada submitted it and Ben has not.
- Lesson 9001 is Class 8A Math with Sarah; Ada is present and Ben is absent.
- Cy has Class 8B attendance, which must not leak into Class 8A lesson output.

