# Design

## What this clinic teaches

Recommended Notifications teaches notification ranking as a constrained feed with urgency, user controls, dedupe, and fatigue.

## Named users/content and why each exists

- Item: Ben notification ben_posted
- Why it exists: Ben close-friend update has high urgency and open probability.
- Simulation/proof that uses it: sent_exact.
- Wrong behavior if removed: close-friend notification would not be represented.

- Item: Ben duplicate ben_posted_duplicate
- Why it exists: Duplicate source event proves dedupe by source_event_id.
- Simulation/proof that uses it: dedupe_exact.
- Wrong behavior if removed: Ada could receive the same Ben push twice.

- Item: Maya notification maya_thread
- Why it exists: Maya active thread is the second allowed send.
- Simulation/proof that uses it: sent_exact.
- Wrong behavior if removed: thread urgency would be ignored.

- Item: Lina notification lina_similar_topic
- Why it exists: Lina arrives during quiet hours and proves quiet-hour control.
- Simulation/proof that uses it: excluded_notifications.
- Wrong behavior if removed: quiet-hour suppression would be untested.

- Item: Noor notification noor_blocked
- Why it exists: Noor is blocked and proves safety/user control exclusion.
- Simulation/proof that uses it: excluded_notifications.
- Wrong behavior if removed: blocked push could be sent.

- Item: Omar notification omar_trending
- Why it exists: Omar proves trending does not beat fatigue cap.
- Simulation/proof that uses it: fatigue_limit.
- Wrong behavior if removed: trending could exceed max notifications per day.

## Broken ranking behavior

broken output sends every notification, duplicates Ben, sends quiet-hours Lina, sends blocked Noor, and ignores fatigue.

## Exact wrong result from the broken version

broken output sends every notification, duplicates Ben, sends quiet-hours Lina, sends blocked Noor, and ignores fatigue.

## Correct result from the solution

The corrected simulation returns [ben_posted,maya_thread].

## Proof assertions

The proof checks expected IDs, exact ordering, exclusion behavior, reason labels or trace fields, and clinic-specific constraints from the dataset. Failure messages name expected sent notifications [ben_posted,maya_thread]; broken sender duplicated Ben, ignored quiet hours, sent blocked Noor, or exceeded daily fatigue limit.

## What the learner should notice

Ben duplicate ben_posted_duplicate survives for a specific reason, Lina notification lina_similar_topic proves exclusion or constraint handling, and the final output is deterministic so a changed rule creates a visible regression.

## Interview explanation target

Explain recommended notifications using Ada and the exact items in this folder, then describe why the broken output is wrong before discussing trade-offs.
