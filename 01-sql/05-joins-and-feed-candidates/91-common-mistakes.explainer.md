# Common Mistakes Explained

## 1. inner join removes post 102 because it has zero comments

- The mistake 1: inner join removes post 102 because it has zero comments.
- Why it feels reasonable 1: in Joins and Feed Candidates, the happy path still returns something because Ben post 101 row multiplication exists, but mistake 1 ignores the row that should constrain the answer.
- The production bug it creates 1: Ben post 101 row multiplication is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 1: inspect Ben post 101 row multiplication, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 1: the SQL for mistake 1 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 1: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 2. likes and comments multiply rows for post 101

- The mistake 2: likes and comments multiply rows for post 101.
- Why it feels reasonable 2: in Joins and Feed Candidates, the happy path still returns something because Ben post 101 row multiplication exists, but mistake 2 ignores the row that should constrain the answer.
- The production bug it creates 2: Ben post 102 zero comments is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 2: inspect Ben post 102 zero comments, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 2: the SQL for mistake 2 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 2: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 3. missing block or mute filters

- The mistake 3: missing block or mute filters.
- Why it feels reasonable 3: in Joins and Feed Candidates, the happy path still returns something because Ben post 101 row multiplication exists, but mistake 3 ignores the row that should constrain the answer.
- The production bug it creates 3: Cy/Noor exclusions is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 3: inspect Cy/Noor exclusions, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 3: the SQL for mistake 3 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 3: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 4. ranking before candidate filtering

- The mistake 4: ranking before candidate filtering.
- Why it feels reasonable 4: in Joins and Feed Candidates, the happy path still returns something because Ben post 101 row multiplication exists, but mistake 4 ignores the row that should constrain the answer.
- The production bug it creates 4: Ben post 101 row multiplication is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 4: inspect Ben post 101 row multiplication, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 4: the SQL for mistake 4 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 4: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 5. joining profile data into the count query before isolating metrics

- The mistake 5: joining profile data into the count query before isolating metrics.
- Why it feels reasonable 5: in Joins and Feed Candidates, the happy path still returns something because Ben post 101 row multiplication exists, but mistake 5 ignores the row that should constrain the answer.
- The production bug it creates 5: Ben post 102 zero comments is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 5: inspect Ben post 102 zero comments, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 5: the SQL for mistake 5 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 5: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.
