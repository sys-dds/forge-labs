# Beginner Walkthrough

This clinic solves exposure budgets and popularity-bias control for Ada by comparing user demand with creator or seller supply before final ranking. Beginners often confuse relevance with ecosystem health: the top raw score can be relevant while also overexposed, risky, too repetitive, too far away, or untrusted.

The broken system did this: post_101, post_201, post_501, post_301 from engagement only; blocked Noor is not filtered and exposure rows are absent.

The corrected system did this: post_101, post_301, post_401, post_601 with Noor rejected, Omar suppressed, and Ben capped after one page slot.

Rows that prove the lesson: creator_ben, creator_diya, creator_maya, creator_omar, creator_lina. A tiny calculation to inspect is `shown / target`: if a creator has 900 shown events against a 300 target, the exposure ratio is 3.0, so the ranker needs a popularity-bias control before filling every slot with the same creator.
