# Beginner Walkthrough

This clinic solves cold-start creator ranking and exploration slots for Ada by comparing user demand with creator or seller supply before final ranking. Beginners often confuse relevance with ecosystem health: the top raw score can be relevant while also overexposed, risky, too repetitive, too far away, or untrusted.

The broken system did this: post_101, post_501, post_201 from historical engagement and unsafe leakage.

The corrected system did this: post_101, post_201 with unsafe, low-fit, incomplete, and clickbait rows treated before rank blending.

Rows that prove the lesson: creator_ben, creator_maya, creator_lina, creator_theo, creator_omar. A tiny calculation to inspect is `shown / target`: if a creator has 900 shown events against a 300 target, the exposure ratio is 3.0, so the ranker needs a popularity-bias control before filling every slot with the same creator.
