# Common Mistakes Explained

## 1. profile table with separate id but no unique user_id

- Mistake: profile table with separate id but no unique user_id.
- Why it feels reasonable: in Tables and Relationships, the happy path still returns something because Ada duplicate profile exists, but mistake 1 ignores the row that should constrain the answer.
- The production bug it creates: Ada duplicate profile is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 1: inspect Ada duplicate profile, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it: the SQL for mistake 1 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 1: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 2. posts without author foreign key

- The mistake 2: posts without author foreign key.
- Why it feels reasonable 2: in Tables and Relationships, the happy path still returns something because Ada duplicate profile exists, but mistake 2 ignores the row that should constrain the answer.
- The production bug it creates 2: Ben missing settings is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 2: inspect Ben missing settings, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 2: the SQL for mistake 2 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 2: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 3. follows_preview with surrogate id but no unique pair

- The mistake 3: follows_preview with surrogate id but no unique pair.
- Why it feels reasonable 3: in Tables and Relationships, the happy path still returns something because Ada duplicate profile exists, but mistake 3 ignores the row that should constrain the answer.
- The production bug it creates 3: follows_preview duplicate is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 3: inspect follows_preview duplicate, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 3: the SQL for mistake 3 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 3: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 4. optional settings forced onto users as nullable columns

- The mistake 4: optional settings forced onto users as nullable columns.
- Why it feels reasonable 4: in Tables and Relationships, the happy path still returns something because Ada duplicate profile exists, but mistake 4 ignores the row that should constrain the answer.
- The production bug it creates 4: Ada duplicate profile is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 4: inspect Ada duplicate profile, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 4: the SQL for mistake 4 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 4: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 5. using SELECT star as the schema mental model

- The mistake 5: using SELECT star as the schema mental model.
- Why it feels reasonable 5: in Tables and Relationships, the happy path still returns something because Ada duplicate profile exists, but mistake 5 ignores the row that should constrain the answer.
- The production bug it creates 5: Ben missing settings is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 5: inspect Ben missing settings, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 5: the SQL for mistake 5 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 5: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.
