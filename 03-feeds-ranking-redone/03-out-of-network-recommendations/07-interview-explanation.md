# Interview Explanation

## Direct answer

I would describe this as out-of-network recommendations: build the candidate set, remove disallowed items, compute transparent signals, and return [501,601,701,901] with reasons.

## Dataset walkthrough

Ada is the viewer. Lina post 501, Lina post 502, Maya post 601, Noor post 801, Theo post 901 are the rows I would walk through because each one affects the proof.

## Ranking reasoning

The solution ranks only after eligibility and source handling. The corrected output is [501,601,701,901]; the broken result is wrong because broken output uses trending only, returns Noor 801, repeats Lina 501 and 502, and omits cold-start Theo 901.

## Common mistake

A common mistake is to treat a high score as permission to show an item. Maya post 601 shows why the rule must be checked before the final page exists.

## Senior trade-off

I would keep the first version explainable with source labels, score parts, and rejection reasons. Faster retrieval or deeper models can come later only after the deterministic replay stays correct.

## Follow-up answer

If this became too slow, I would cache candidate pools or precompute some features, but I would keep the eligibility checks, reason labels, and replay proof intact.
