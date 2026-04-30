# Beginner Walkthrough

This clinic solves seller quality trust fulfilment and response ranking for Ada by comparing user demand with creator or seller supply before final ranking. Beginners often confuse relevance with ecosystem health: the top raw score can be relevant while also overexposed, risky, too repetitive, too far away, or untrusted.

The broken system did this: listing_501, listing_101, listing_301, listing_401 by rating only, leaking blocked and risky sellers.

The corrected system did this: listing_101, listing_201, listing_401 with Omar suppressed and Maya allowed as clean cold-start seller.

Rows that prove the lesson: listing_101, listing_201, listing_301, listing_401, listing_501. A tiny calculation to inspect is `shown / target`: if a creator has 900 shown events against a 300 target, the exposure ratio is 3.0, so the ranker needs a popularity-bias control before filling every slot with the same creator.
