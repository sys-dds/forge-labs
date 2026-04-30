# Beginner Walkthrough

This clinic solves a graph retrieval problem: find candidates through nodes and edges before ranking runs.

Beginners often confuse graph retrieval with ranking. Ranking orders candidates after they exist; graph retrieval decides whether javaconf, backend_newsletter, post_101, post_201 can be reached at all.

The broken system returned `[post_101, post_201, spam_event]` because it skipped the clinic's graph rule and did not preserve useful path evidence.

The corrected system follows the graph rule for heterogeneous source paths and node-type quotas, applies exclusions, and returns `javaconf, backend_newsletter, post_101, post_201`.

The proving rows are the candidate pool, rejected or missed rows, and the debug trace. A tiny calculation here is: one kept candidate must have one visible source path, while one rejected or missed row must have a concrete graph-stage reason.
