# Common Mistakes Explained

## 1. ROW_NUMBER without deterministic tie-breaker

- The mistake 1: ROW_NUMBER without deterministic tie-breaker.
- Why it feels reasonable 1: in Window Functions and Ranking Inputs, the happy path still returns something because latest Ada post exists, but mistake 1 ignores the row that should constrain the answer.
- The production bug it creates 1: latest Ada post is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 1: inspect latest Ada post, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 1: the SQL for mistake 1 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 1: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 2. confusing RANK and DENSE_RANK

- The mistake 2: confusing RANK and DENSE_RANK.
- Why it feels reasonable 2: in Window Functions and Ranking Inputs, the happy path still returns something because latest Ada post exists, but mistake 2 ignores the row that should constrain the answer.
- The production bug it creates 2: rank tie gap is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 2: inspect rank tie gap, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 2: the SQL for mistake 2 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 2: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 3. running total without PARTITION BY

- The mistake 3: running total without PARTITION BY.
- Why it feels reasonable 3: in Window Functions and Ranking Inputs, the happy path still returns something because latest Ada post exists, but mistake 3 ignores the row that should constrain the answer.
- The production bug it creates 3: author partition is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 3: inspect author partition, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 3: the SQL for mistake 3 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 3: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 4. treating rank label as the final algorithm

- The mistake 4: treating rank label as the final algorithm.
- Why it feels reasonable 4: in Window Functions and Ranking Inputs, the happy path still returns something because latest Ada post exists, but mistake 4 ignores the row that should constrain the answer.
- The production bug it creates 4: latest Ada post is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 4: inspect latest Ada post, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 4: the SQL for mistake 4 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 4: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 5. filtering a window alias in the same query layer

- The mistake 5: filtering a window alias in the same query layer.
- Why it feels reasonable 5: in Window Functions and Ranking Inputs, the happy path still returns something because latest Ada post exists, but mistake 5 ignores the row that should constrain the answer.
- The production bug it creates 5: rank tie gap is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 5: inspect rank tie gap, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 5: the SQL for mistake 5 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 5: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.
