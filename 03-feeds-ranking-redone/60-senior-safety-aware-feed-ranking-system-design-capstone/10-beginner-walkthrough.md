# Beginner Walkthrough

This clinic solves a safety/integrity problem where ranking alone would make the wrong product decision.

Beginners often confuse safety with ranking and try to lower every risky score. The corrected version chooses remove, reduce, inform, review, or allow.

The broken system did: `score-only feed leaks spam/blocked`.

The corrected system produces: `post_101, post_501, post_601, post_901, post_301, post_401`.

The proving rows are rejected/downranked/informed/review/audit entries plus a safety_debug_trace. A tiny calculation is checking one risk row, mapping it to one treatment, and confirming the final feed reflects that treatment.
