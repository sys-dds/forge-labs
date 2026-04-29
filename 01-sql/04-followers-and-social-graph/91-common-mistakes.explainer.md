# Common Mistakes Explained

## 1. reversing follower_id and followee_id

- Mistake: reversing follower_id and followee_id.
- Why it feels reasonable: in Followers and Social Graph, the happy path still returns something because Ada suggestions should be Diya exists, but mistake 1 ignores the row that should constrain the answer.
- The production bug it creates: Ada suggestions should be Diya is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 1: inspect Ada suggestions should be Diya, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it: the SQL for mistake 1 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 1: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 2. suggestions include already-followed users

- The mistake 2: suggestions include already-followed users.
- Why it feels reasonable 2: in Followers and Social Graph, the happy path still returns something because Ada suggestions should be Diya exists, but mistake 2 ignores the row that should constrain the answer.
- The production bug it creates 2: Noor blocked but reachable is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 2: inspect Noor blocked but reachable, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 2: the SQL for mistake 2 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 2: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 3. suggestions include Ada herself

- The mistake 3: suggestions include Ada herself.
- Why it feels reasonable 3: in Followers and Social Graph, the happy path still returns something because Ada suggestions should be Diya exists, but mistake 3 ignores the row that should constrain the answer.
- The production bug it creates 3: Cy muted but still followed is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 3: inspect Cy muted but still followed, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 3: the SQL for mistake 3 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 3: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 4. suggestions include blocked Noor

- The mistake 4: suggestions include blocked Noor.
- Why it feels reasonable 4: in Followers and Social Graph, the happy path still returns something because Ada suggestions should be Diya exists, but mistake 4 ignores the row that should constrain the answer.
- The production bug it creates 4: Ada suggestions should be Diya is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 4: inspect Ada suggestions should be Diya, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 4: the SQL for mistake 4 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 4: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.

## 5. treating mute like block or deleting the follow row

- The mistake 5: treating mute like block or deleting the follow row.
- Why it feels reasonable 5: in Followers and Social Graph, the happy path still returns something because Ada suggestions should be Diya exists, but mistake 5 ignores the row that should constrain the answer.
- The production bug it creates 5: Noor blocked but reachable is mishandled in a way that a real endpoint would expose to a user or ranking job.
- The exact dataset row/proof that exposes it 5: inspect Noor blocked but reachable, remove the related guard, and rerun the proof until the failure names the wrong behavior.
- How the correct solution avoids it 5: the SQL for mistake 5 keeps the row in the dataset and protects it with the chapter's specific guard rather than hiding the case.
- How to explain it in an interview 5: say which named row is admitted, duplicated, or rejected incorrectly, then name the constraint or predicate that makes the authored version safe.
