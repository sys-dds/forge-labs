# Common Mistakes Explained

## 1. ordering only by created_at

- The mistake 1: ordering only by created_at.
- Why it feels reasonable 1: in Pagination and Cursors, the happy path still returns something because timestamp tie 105/104 exists, but mistake 1 ignores the row that should constrain the answer.
- The production bug it creates 1: timestamp tie 105/104 is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 1: inspect timestamp tie 105/104, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 1: the SQL for mistake 1 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 1: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 2. using offset for a changing feed

- The mistake 2: using offset for a changing feed.
- Why it feels reasonable 2: in Pagination and Cursors, the happy path still returns something because timestamp tie 105/104 exists, but mistake 2 ignores the row that should constrain the answer.
- The production bug it creates 2: new post 107 before page two is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 2: inspect new post 107 before page two, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 2: the SQL for mistake 2 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 2: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 3. cursor without id tie-breaker

- The mistake 3: cursor without id tie-breaker.
- Why it feels reasonable 3: in Pagination and Cursors, the happy path still returns something because timestamp tie 105/104 exists, but mistake 3 ignores the row that should constrain the answer.
- The production bug it creates 3: cursor boundary 104 is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 3: inspect cursor boundary 104, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 3: the SQL for mistake 3 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 3: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 4. using page number as cursor

- The mistake 4: using page number as cursor.
- Why it feels reasonable 4: in Pagination and Cursors, the happy path still returns something because timestamp tie 105/104 exists, but mistake 4 ignores the row that should constrain the answer.
- The production bug it creates 4: timestamp tie 105/104 is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 4: inspect timestamp tie 105/104, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 4: the SQL for mistake 4 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 4: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 5. reversing DESC keyset comparison

- The mistake 5: reversing DESC keyset comparison.
- Why it feels reasonable 5: in Pagination and Cursors, the happy path still returns something because timestamp tie 105/104 exists, but mistake 5 ignores the row that should constrain the answer.
- The production bug it creates 5: new post 107 before page two is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 5: inspect new post 107 before page two, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 5: the SQL for mistake 5 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 5: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.
