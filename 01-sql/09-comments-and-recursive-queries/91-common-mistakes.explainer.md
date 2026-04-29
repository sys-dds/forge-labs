# Common Mistakes Explained

## 1. recursive query without a clear base case

- Mistake: recursive query without a clear base case.
- Why it feels reasonable: in Comments and Recursive Queries, the happy path still returns something because c1 thread exists, but mistake 1 ignores the row that should constrain the answer.
- The production bug it creates: c1 thread is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 1: inspect c1 thread, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it: the SQL for mistake 1 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 1: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 2. no parent foreign key

- The mistake 2: no parent foreign key.
- Why it feels reasonable 2: in Comments and Recursive Queries, the happy path still returns something because c1 thread exists, but mistake 2 ignores the row that should constrain the answer.
- The production bug it creates 2: post 200 exclusion is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 2: inspect post 200 exclusion, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 2: the SQL for mistake 2 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 2: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 3. not scoping recursion to the post

- The mistake 3: not scoping recursion to the post.
- Why it feels reasonable 3: in Comments and Recursive Queries, the happy path still returns something because c1 thread exists, but mistake 3 ignores the row that should constrain the answer.
- The production bug it creates 3: category tree reuse is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 3: inspect category tree reuse, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 3: the SQL for mistake 3 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 3: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 4. unstable path ordering

- The mistake 4: unstable path ordering.
- Why it feels reasonable 4: in Comments and Recursive Queries, the happy path still returns something because c1 thread exists, but mistake 4 ignores the row that should constrain the answer.
- The production bug it creates 4: c1 thread is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 4: inspect c1 thread, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 4: the SQL for mistake 4 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 4: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 5. no cycle strategy discussion

- The mistake 5: no cycle strategy discussion.
- Why it feels reasonable 5: in Comments and Recursive Queries, the happy path still returns something because c1 thread exists, but mistake 5 ignores the row that should constrain the answer.
- The production bug it creates 5: post 200 exclusion is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 5: inspect post 200 exclusion, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 5: the SQL for mistake 5 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 5: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.
