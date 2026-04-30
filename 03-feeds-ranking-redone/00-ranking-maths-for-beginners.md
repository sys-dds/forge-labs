# Ranking Maths For Beginners

A readable ranker is just arithmetic with names. Clinic 20 shows the shape:

`normalised_engagement + affinity_boost + completion_boost + exploration_boost - age_decay - report_penalty`

Normalisation keeps large raw counts from overwhelming everything. Decay lets old items lose strength. A boost moves a wanted signal up. A penalty moves a risky or less suitable signal down.

Debugging steps:

1. Print the score row.
2. Check each component.
3. Compare two neighboring items.
4. Change one weight.
5. Rerun the proof and explain the order out loud.
