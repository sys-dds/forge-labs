# Interview Explanation

## Direct answer

I would describe this as candidate mixing and deduplication: build the candidate set, remove disallowed items, compute transparent signals, and return [101,501,601,701,901] with reasons.

## Dataset walkthrough

Ada is the viewer. Ben post 102, Lina post 501, Maya post 601, Omar post 701, Theo post 901 are the rows I would walk through because each one affects the proof.

## Ranking reasoning

The solution ranks only after eligibility and source handling. The corrected output is [101,501,601,701,901]; the broken result is wrong because broken output repeats Lina 501 three times, loses reasons, and lets trending dominate the page.

## Common mistake

A common mistake is to treat a high score as permission to show an item. Maya post 601 shows why the rule must be checked before the final page exists.

## Senior trade-off

I would keep the first version explainable with source labels, score parts, and rejection reasons. Faster retrieval or deeper models can come later only after the deterministic replay stays correct.

## Follow-up answer

If this became too slow, I would cache candidate pools or precompute some features, but I would keep the eligibility checks, reason labels, and replay proof intact.
