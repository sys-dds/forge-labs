# Break/Fix Drills

1. Treat `PASS` as if it were `LIKE`.
   - Cy becomes a false mutual match with Ada.
   - Fix by filtering both sides of the mutual match query to `action = 'LIKE'`.

2. Remove the already-swiped exclusion.
   - Ben or Cy can appear in raw candidates even though Ada already acted on them.
   - Fix by restoring the anti-join against Ada's swipes.

3. Remove the active profile filter.
   - Noor appears even though Noor is inactive.
   - Fix by requiring `candidate.active`.

4. Apply preference fit before safety exclusions.
   - The query can spend effort explaining why blocked or already-swiped users fit preferences.
   - Fix by making safety and action exclusions define the raw candidate set first.
