# Interview Explanation

## Direct answer

I would describe this as social graph candidate generation: build the candidate set, remove disallowed items, compute transparent signals, and return [101,401,501] with reasons.

## Dataset walkthrough

Ada is the viewer. Cy post 201, Noor post 301, Diya post 401, Lina post 501, Theo post 601 are the rows I would walk through because each one affects the proof.

## Ranking reasoning

The solution ranks only after eligibility and source handling. The corrected output is [101,401,501]; the broken result is wrong because broken candidates include Cy 201, Noor 301, Theo 601, miss Diya 401, and can duplicate Lina 501.

## Common mistake

A common mistake is to treat a high score as permission to show an item. Diya post 401 shows why the rule must be checked before the final page exists.

## Senior trade-off

I would keep the first version explainable with source labels, score parts, and rejection reasons. Faster retrieval or deeper models can come later only after the deterministic replay stays correct.

## Follow-up answer

If this became too slow, I would cache candidate pools or precompute some features, but I would keep the eligibility checks, reason labels, and replay proof intact.
