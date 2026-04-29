# People You May Know

Ada opens a social graph surface that suggests people she might follow next. The query starts with directed `follows` edges, walks from Ada to the people she follows, then walks one more edge to their followees.

The hard part is not finding reachable people. The hard part is removing unsafe or useless suggestions: Ada herself, users she already follows, blocked users, and duplicate paths that point at the same person.

Run the pack:

```bash
./scripts/forge-load-practice.sh 01-sql/_practice/01-social-graph-suggestions
./scripts/forge-test-practice.sh 01-sql/_practice/01-social-graph-suggestions
```

Expected final view: `ada_safe_suggestions`
