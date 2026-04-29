# Common Mistakes Explained

## 1. SELECT star leaking email

- The mistake 1: SELECT star leaking email.
- Why it feels reasonable 1: in Profile and User Querying, the happy path still returns something because Ada public card exists, but mistake 1 ignores the row that should constrain the answer.
- The production bug it creates 1: Ada public card is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 1: inspect Ada public card, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 1: the SQL for mistake 1 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 1: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 2. profile counts inflated by joining posts and follows together

- The mistake 2: profile counts inflated by joining posts and follows together.
- Why it feels reasonable 2: in Profile and User Querying, the happy path still returns something because Ada public card exists, but mistake 2 ignores the row that should constrain the answer.
- The production bug it creates 2: Cy non-searchable profile is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 2: inspect Cy non-searchable profile, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 2: the SQL for mistake 2 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 2: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 3. private profile returned by search

- The mistake 3: private profile returned by search.
- Why it feels reasonable 3: in Profile and User Querying, the happy path still returns something because Ada public card exists, but mistake 3 ignores the row that should constrain the answer.
- The production bug it creates 3: email projection boundary is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 3: inspect email projection boundary, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 3: the SQL for mistake 3 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 3: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 4. returning database table shape as API shape

- The mistake 4: returning database table shape as API shape.
- Why it feels reasonable 4: in Profile and User Querying, the happy path still returns something because Ada public card exists, but mistake 4 ignores the row that should constrain the answer.
- The production bug it creates 4: Ada public card is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 4: inspect Ada public card, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 4: the SQL for mistake 4 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 4: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 5. missing handle converted into a fake error row

- The mistake 5: missing handle converted into a fake error row.
- Why it feels reasonable 5: in Profile and User Querying, the happy path still returns something because Ada public card exists, but mistake 5 ignores the row that should constrain the answer.
- The production bug it creates 5: Cy non-searchable profile is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 5: inspect Cy non-searchable profile, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 5: the SQL for mistake 5 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 5: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.
