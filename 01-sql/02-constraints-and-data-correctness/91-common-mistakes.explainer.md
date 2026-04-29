# Common Mistakes Explained

## 1. app-only duplicate follow check

- The mistake 1: app-only duplicate follow check.
- Why it feels reasonable 1: in Constraints and Data Correctness, the happy path still returns something because Ada to Ben duplicate follow exists, but mistake 1 ignores the row that should constrain the answer.
- The production bug it creates 1: Ada to Ben duplicate follow is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 1: inspect Ada to Ben duplicate follow, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 1: the SQL for mistake 1 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 1: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 2. no self-follow CHECK

- The mistake 2: no self-follow CHECK.
- Why it feels reasonable 2: in Constraints and Data Correctness, the happy path still returns something because Ada to Ben duplicate follow exists, but mistake 2 ignores the row that should constrain the answer.
- The production bug it creates 2: Ada self-follow is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 2: inspect Ada self-follow, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 2: the SQL for mistake 2 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 2: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 3. nullable required facts

- The mistake 3: nullable required facts.
- Why it feels reasonable 3: in Constraints and Data Correctness, the happy path still returns something because Ada to Ben duplicate follow exists, but mistake 3 ignores the row that should constrain the answer.
- The production bug it creates 3: missing user 999 is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 3: inspect missing user 999, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 3: the SQL for mistake 3 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 3: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 4. missing foreign key on follows

- The mistake 4: missing foreign key on follows.
- Why it feels reasonable 4: in Constraints and Data Correctness, the happy path still returns something because Ada to Ben duplicate follow exists, but mistake 4 ignores the row that should constrain the answer.
- The production bug it creates 4: Ada to Ben duplicate follow is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 4: inspect Ada to Ben duplicate follow, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 4: the SQL for mistake 4 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 4: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 5. unique handle enforced only in code

- The mistake 5: unique handle enforced only in code.
- Why it feels reasonable 5: in Constraints and Data Correctness, the happy path still returns something because Ada to Ben duplicate follow exists, but mistake 5 ignores the row that should constrain the answer.
- The production bug it creates 5: Ada self-follow is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 5: inspect Ada self-follow, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 5: the SQL for mistake 5 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 5: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.
