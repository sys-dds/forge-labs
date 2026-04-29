# Common Mistakes Explained

## 1. duplicate swipes allowed

- The mistake 1: duplicate swipes allowed.
- Why it feels reasonable 1: in Matching SQL, Swipes, and Mutual Matches, the happy path still returns something because Ada-Ben mutual LIKE exists, but mistake 1 ignores the row that should constrain the answer.
- The production bug it creates 1: Ada-Ben mutual LIKE is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 1: inspect Ada-Ben mutual LIKE, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 1: the SQL for mistake 1 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 1: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 2. self-swipe allowed

- The mistake 2: self-swipe allowed.
- Why it feels reasonable 2: in Matching SQL, Swipes, and Mutual Matches, the happy path still returns something because Ada-Ben mutual LIKE exists, but mistake 2 ignores the row that should constrain the answer.
- The production bug it creates 2: Cy PASS is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 2: inspect Cy PASS, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 2: the SQL for mistake 2 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 2: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 3. PASS treated as a match

- The mistake 3: PASS treated as a match.
- Why it feels reasonable 3: in Matching SQL, Swipes, and Mutual Matches, the happy path still returns something because Ada-Ben mutual LIKE exists, but mistake 3 ignores the row that should constrain the answer.
- The production bug it creates 3: Maya/Omar candidate split is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 3: inspect Maya/Omar candidate split, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 3: the SQL for mistake 3 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 3: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 4. already-swiped users included

- The mistake 4: already-swiped users included.
- Why it feels reasonable 4: in Matching SQL, Swipes, and Mutual Matches, the happy path still returns something because Ada-Ben mutual LIKE exists, but mistake 4 ignores the row that should constrain the answer.
- The production bug it creates 4: Ada-Ben mutual LIKE is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 4: inspect Ada-Ben mutual LIKE, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 4: the SQL for mistake 4 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 4: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 5. blocked or inactive users reaching scoring

- The mistake 5: blocked or inactive users reaching scoring.
- Why it feels reasonable 5: in Matching SQL, Swipes, and Mutual Matches, the happy path still returns something because Ada-Ben mutual LIKE exists, but mistake 5 ignores the row that should constrain the answer.
- The production bug it creates 5: Cy PASS is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 5: inspect Cy PASS, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 5: the SQL for mistake 5 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 5: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 6. preference fit mixed unclearly with safety exclusions

- The mistake 6: preference fit mixed unclearly with safety exclusions.
- Why it feels reasonable 6: in Matching SQL, Swipes, and Mutual Matches, the happy path still returns something because Ada-Ben mutual LIKE exists, but mistake 6 ignores the row that should constrain the answer.
- The production bug it creates 6: Maya/Omar candidate split is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 6: inspect Maya/Omar candidate split, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 6: the SQL for mistake 6 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 6: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 7. ranking before exclusions

- The mistake 7: ranking before exclusions.
- Why it feels reasonable 7: in Matching SQL, Swipes, and Mutual Matches, the happy path still returns something because Ada-Ben mutual LIKE exists, but mistake 7 ignores the row that should constrain the answer.
- The production bug it creates 7: Ada-Ben mutual LIKE is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 7: inspect Ada-Ben mutual LIKE, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 7: the SQL for mistake 7 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 7: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.
