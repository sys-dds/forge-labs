# Interview Explanation

## Direct answer

I would describe this as stories and ephemeral content: build the candidate set, remove disallowed items, compute transparent signals, and return stories [101], spotlight [701,501] with reasons.

## Dataset walkthrough

Ada is the viewer. Ben story 101, Ben story 102, Cy story 201, Noor story 301, Maya Spotlight 701 are the rows I would walk through because each one affects the proof.

## Ranking reasoning

The solution ranks only after eligibility and source handling. The corrected output is stories [101], spotlight [701,501]; the broken result is wrong because broken output includes expired Ben 102, muted Cy 201, blocked Noor 301, wrong-language Omar 601, and reported Theo 801 while ranking Spotlight by likes only.

## Common mistake

A common mistake is to treat a high score as permission to show an item. Cy story 201 shows why the rule must be checked before the final page exists.

## Senior trade-off

I would keep the first version explainable with source labels, score parts, and rejection reasons. Faster retrieval or deeper models can come later only after the deterministic replay stays correct.

## Follow-up answer

If this became too slow, I would cache candidate pools or precompute some features, but I would keep the eligibility checks, reason labels, and replay proof intact.
