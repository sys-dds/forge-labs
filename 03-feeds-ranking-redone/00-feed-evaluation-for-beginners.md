# Feed Evaluation For Beginners

## Replay

Plain-English meaning: run the same fixed inventory through the feed code and compare the result with a known good answer.

Tiny example from clinic 21: items 701 and 801 are rejected, while 901 stays because exploration is reserved.

Common beginner mistake: checking only that the feed has four items.

How to debug it: print the rejected item IDs and the regression report before looking at scores.

What a senior engineer asks next: can this replay run before every risky ranking change?

## Golden feed

Plain-English meaning: the expected output for a fixed dataset.

Tiny example from clinic 21: the golden feed is [101, 501, 601, 901].

Common beginner mistake: copying the golden output instead of deriving it.

How to debug it: mutate one eligibility rule and confirm the proof catches the changed trace.

What a senior engineer asks next: which user promises does the golden feed protect?

## Metric review

Plain-English meaning: compare behavior with several metrics, not one attractive number.

Tiny example from clinic 25: Variant A has higher CTR, but Variant B wins on completion, hides, dwell, and diversity.

Common beginner mistake: treating CTR as the whole product.

How to debug it: put each metric in one row and mark the guardrail that fails.

What a senior engineer asks next: which metric can be gamed, and which one protects users or creators?
