# Joins and Feed Candidates Dataset Story

## Scenario
Ada opens her feed. SQL must decide which posts are eligible before any ranking layer scores them.

## Named Dataset Rows
- ada follows ben, cy, and noor.
- ada mutes cy and blocks noor.
- diya is not followed.
- ben posts 101 and 102.
- cy post 201, noor post 301, diya post 401.
- post 101 has two likes and three comments.

## Why Each Important Row Exists
- Teaching row 1: ada follows ben, cy, and noor. It anchors a row that should appear in a correct result.
- Teaching row 2: ada mutes cy and blocks noor. It anchors an exclusion or edge condition the proof can name.
- Teaching row 3: diya is not followed. It anchors a row that should appear in a correct result.
- Teaching row 4: ben posts 101 and 102. It anchors an exclusion or edge condition the proof can name.
- Teaching row 5: cy post 201, noor post 301, diya post 401. It anchors a row that should appear in a correct result.
- Teaching row 6: post 101 has two likes and three comments. It anchors an exclusion or edge condition the proof can name.

## Positive Cases
- feed candidates are Ben posts 101 and 102.
- post 102 survives despite zero comments.
- author profile fields are attached.

## Negative/Exclusion Cases
- cy is excluded by mute.
- noor is excluded by block.
- diya is excluded because Ada does not follow her.
- bad multiplication query inflates post 101.

## Edge Cases
- At least one row is intentionally boring or empty so the query cannot rely on every user having every related row.
- At least one row is intentionally reachable or joinable but must still be excluded by policy.
- At least one assertion checks exact names, ids, or counts so a broad query cannot pass by accident.

## Proof Assertions
- The proof asserts that feed candidates are Ben posts 101 and 102.
- The proof asserts that post 102 survives despite zero comments.
- The proof asserts that author profile fields are attached.
- The proof asserts that cy is excluded by mute.
- The proof asserts that noor is excluded by block.
- The proof asserts that diya is excluded because Ada does not follow her.
- The proof asserts that bad multiplication query inflates post 101.

## Deliberate Break/Fix
- Break: remove mute predicate. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: remove block predicate. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
- Break: join likes and comments directly and count rows. Fix it by restoring the authored model, rerun the proof, and explain which named row exposed the bug.
