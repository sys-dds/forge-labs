# Common Mistakes Explained

## 1. counting hidden posts

- Mistake: counting hidden posts.
- Why it feels reasonable: in Aggregation and Counts, the happy path still returns something because Ada hidden post exists, but mistake 1 ignores the row that should constrain the answer.
- The production bug it creates: Ada hidden post is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 1: inspect Ada hidden post, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it: the SQL for mistake 1 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 1: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 2. counting deleted comments

- The mistake 2: counting deleted comments.
- Why it feels reasonable 2: in Aggregation and Counts, the happy path still returns something because Ada hidden post exists, but mistake 2 ignores the row that should constrain the answer.
- The production bug it creates 2: deleted comment on A1 is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 2: inspect deleted comment on A1, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 2: the SQL for mistake 2 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 2: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 3. COUNT star after a join inflates metrics

- The mistake 3: COUNT star after a join inflates metrics.
- Why it feels reasonable 3: in Aggregation and Counts, the happy path still returns something because Ada hidden post exists, but mistake 3 ignores the row that should constrain the answer.
- The production bug it creates 3: COUNT DISTINCT proof is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 3: inspect COUNT DISTINCT proof, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 3: the SQL for mistake 3 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 3: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 4. using WHERE where HAVING is required

- The mistake 4: using WHERE where HAVING is required.
- Why it feels reasonable 4: in Aggregation and Counts, the happy path still returns something because Ada hidden post exists, but mistake 4 ignores the row that should constrain the answer.
- The production bug it creates 4: Ada hidden post is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 4: inspect Ada hidden post, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 4: the SQL for mistake 4 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 4: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 5. treating metrics as harmless even when ranking consumes them

- The mistake 5: treating metrics as harmless even when ranking consumes them.
- Why it feels reasonable 5: in Aggregation and Counts, the happy path still returns something because Ada hidden post exists, but mistake 5 ignores the row that should constrain the answer.
- The production bug it creates 5: deleted comment on A1 is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 5: inspect deleted comment on A1, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 5: the SQL for mistake 5 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 5: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.
