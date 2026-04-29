# Constraints and Correctness Common Mistakes

1. **App-only duplicate checks**: Two concurrent requests can both pass the check before either insert commits.
2. **No self-follow check**: Self relationships pollute graph queries and recommendations.
3. **Missing foreign keys**: Invalid references make every join less trustworthy.
