# Beginner Walkthrough

This clinic solves creator marketplace ranking system design capstone for Ada by comparing user demand with creator or seller supply before final ranking. Beginners often confuse relevance with ecosystem health: the top raw score can be relevant while also overexposed, risky, too repetitive, too far away, or untrusted.

The broken system did this: Raw score leaks listing_701 and post_401, drops long-tail and clean cold-start seller, and produces boolean-only policies.

The corrected system did this: Blended feed keeps creator and marketplace winners with rich policies, missing explanations, and handoff rows.

Rows that prove the lesson: post_101, post_201, post_301, post_401, listing_501. A tiny calculation to inspect is `shown / target`: if a creator has 900 shown events against a 300 target, the exposure ratio is 3.0, so the ranker needs a popularity-bias control before filling every slot with the same creator.
