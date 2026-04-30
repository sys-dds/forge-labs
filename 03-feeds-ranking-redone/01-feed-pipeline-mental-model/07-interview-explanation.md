# Interview Explanation

## Direct answer

I would describe this as feed pipeline stages: build the candidate set, remove disallowed items, compute transparent signals, and return [101,501,401,701] with reasons.

## Dataset walkthrough

Ada is the viewer. Ben post 101, Cy post 201, Noor post 301, Omar post 601, Maya post 701 are the rows I would walk through because each one affects the proof.

## Ranking reasoning

The solution ranks only after eligibility and source handling. The corrected output is [101,501,401,701]; the broken result is wrong because broken output ranks Omar 601, Noor 301, Cy 201, and Lina 501 by raw engagement before removing unsafe rows.

## Common mistake

A common mistake is to treat a high score as permission to show an item. Noor post 301 shows why the rule must be checked before the final page exists.

## Senior trade-off

I would keep the first version explainable with source labels, score parts, and rejection reasons. Faster retrieval or deeper models can come later only after the deterministic replay stays correct.

## Follow-up answer

If this became too slow, I would cache candidate pools or precompute some features, but I would keep the eligibility checks, reason labels, and replay proof intact.
