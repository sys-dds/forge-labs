# Break Fix Drills

1. Rank by likes only; Ben post 102 should jump above Ben post 101.
2. Change comment weight from 4 to 1; Ben post 101's score should drop.
3. Remove author affinity; Maya 301 and Lina 601 should be scored only by engagement/recency.
4. Hide feature columns; the proof should fail because scores are no longer inspectable.
5. Remove `post_id DESC` from the ordering; stable tie-break proof becomes weaker when scores tie.
6. Remove diversity_group; Ben and Lina repeated-author detection disappears.

