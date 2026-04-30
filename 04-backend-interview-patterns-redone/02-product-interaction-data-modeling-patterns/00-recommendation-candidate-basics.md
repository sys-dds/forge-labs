# Recommendation Candidate Basics

Clinic 009 treats recommendation generation as an eligibility and source-label problem, not ranking.

Candidate sources:

- mutual follows from `follow_edges`
- shared interests from `user_interests` and tagged `posts`
- right-swipe signals from `swipe_events`

Exclusions:

- already followed users from `follow_edges`
- already matched users from `matches`
- blocked users from `block_edges`
- reported users from `report_events`
- inactive or undiscoverable users from `users` and `creators`

The proof names Cy, Diya, Eli, Fay, Gus, Hana, and Ivan so the learner can explain both included and excluded rows.
