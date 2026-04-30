# Interview Explanation

## Direct answer

I would describe this as feed evaluation and debugging: build the candidate set, remove disallowed items, compute transparent signals, and return [101,501,601,901] with reasons.

## Dataset walkthrough

Ada is the viewer. Ben post 102, Ben post 103, Lina post 501, Maya post 601, Noor post 701 are the rows I would walk through because each one affects the proof.

## Ranking reasoning

The solution ranks only after eligibility and source handling. The corrected output is [101,501,601,901]; the broken result is wrong because broken output is [701,101,102,103], leaking blocked Noor, repeating Ben, and omitting exploration.

## Common mistake

A common mistake is to treat a high score as permission to show an item. Lina post 501 shows why the rule must be checked before the final page exists.

## Senior trade-off

I would keep the first version explainable with source labels, score parts, and rejection reasons. Faster retrieval or deeper models can come later only after the deterministic replay stays correct.

## Follow-up answer

If this became too slow, I would cache candidate pools or precompute some features, but I would keep the eligibility checks, reason labels, and replay proof intact.
