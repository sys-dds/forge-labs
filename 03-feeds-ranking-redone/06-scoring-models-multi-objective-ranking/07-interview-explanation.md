# Interview Explanation

## Direct answer

I would describe this as multi-objective ranking: build the candidate set, remove disallowed items, compute transparent signals, and return [501,101,601,901,701] with reasons.

## Dataset walkthrough

Ada is the viewer. Lina video 501, Maya post 601, Omar clickbait 701, New creator 901 are the rows I would walk through because each one affects the proof.

## Ranking reasoning

The solution ranks only after eligibility and source handling. The corrected output is [501,101,601,901,701]; the broken result is wrong because broken output ranks Omar 701 first by like probability despite high hide/report risk and hides score components.

## Common mistake

A common mistake is to treat a high score as permission to show an item. Omar clickbait 701 shows why the rule must be checked before the final page exists.

## Senior trade-off

I would keep the first version explainable with source labels, score parts, and rejection reasons. Faster retrieval or deeper models can come later only after the deterministic replay stays correct.

## Follow-up answer

If this became too slow, I would cache candidate pools or precompute some features, but I would keep the eligibility checks, reason labels, and replay proof intact.
