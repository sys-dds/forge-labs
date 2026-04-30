# Interview Explanation

## Direct answer

I would describe this as recommended notifications: build the candidate set, remove disallowed items, compute transparent signals, and return [ben_posted,maya_thread] with reasons.

## Dataset walkthrough

Ada is the viewer. Ben duplicate ben_posted_duplicate, Maya notification maya_thread, Lina notification lina_similar_topic, Noor notification noor_blocked, Omar notification omar_trending are the rows I would walk through because each one affects the proof.

## Ranking reasoning

The solution ranks only after eligibility and source handling. The corrected output is [ben_posted,maya_thread]; the broken result is wrong because broken output sends every notification, duplicates Ben, sends quiet-hours Lina, sends blocked Noor, and ignores fatigue.

## Common mistake

A common mistake is to treat a high score as permission to show an item. Lina notification lina_similar_topic shows why the rule must be checked before the final page exists.

## Senior trade-off

I would keep the first version explainable with source labels, score parts, and rejection reasons. Faster retrieval or deeper models can come later only after the deterministic replay stays correct.

## Follow-up answer

If this became too slow, I would cache candidate pools or precompute some features, but I would keep the eligibility checks, reason labels, and replay proof intact.
