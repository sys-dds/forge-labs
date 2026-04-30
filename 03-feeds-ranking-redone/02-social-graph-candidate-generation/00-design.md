# Design

## What this clinic teaches

Social Graph Candidate Generation teaches outgoing social graph traversal, social proof, group eligibility, and hard mute/block exclusions.

## Named users/content and why each exists

- Item: Ben post 101
- Why it exists: Ben is Ada close friend and proves close_friend beats plain followed.
- Simulation/proof that uses it: candidates_exact.
- Wrong behavior if removed: the source label close_friend would not be tested.

- Item: Cy post 201
- Why it exists: Cy is followed but muted and proves followed is not enough.
- Simulation/proof that uses it: excluded_candidates.
- Wrong behavior if removed: muted followed authors would enter candidates.

- Item: Noor post 301
- Why it exists: Noor is blocked and proves block beats graph reachability.
- Simulation/proof that uses it: excluded_candidates.
- Wrong behavior if removed: blocked content could enter through a follow edge.

- Item: Diya post 401
- Why it exists: Diya shares Ada group and proves group recall exists.
- Simulation/proof that uses it: candidates_exact.
- Wrong behavior if removed: the generator could ignore group membership.

- Item: Lina post 501
- Why it exists: Maya commented on Lina 501 and proves social proof out-of-network recall.
- Simulation/proof that uses it: source_labels_exact.
- Wrong behavior if removed: comment-social-proof would be invisible.

- Item: Theo post 601
- Why it exists: Theo is public but unrelated and proves public is not in-network.
- Simulation/proof that uses it: excluded_candidates.
- Wrong behavior if removed: public inventory would be mislabeled as social graph.

## Broken ranking behavior

broken candidates include Cy 201, Noor 301, Theo 601, miss Diya 401, and can duplicate Lina 501.

## Exact wrong result from the broken version

broken candidates include Cy 201, Noor 301, Theo 601, miss Diya 401, and can duplicate Lina 501.

## Correct result from the solution

The corrected simulation returns [101,401,501].

## Proof assertions

The proof checks expected IDs, exact ordering, exclusion behavior, reason labels or trace fields, and clinic-specific constraints from the dataset. Failure messages name expected social graph candidates [101 close_friend,401 shared_group,501 commented_by_following]; broken generator leaked Cy 201, Noor 301, Theo 601, missed Diya 401, or duplicated Lina 501.

## What the learner should notice

Cy post 201 survives for a specific reason, Diya post 401 proves exclusion or constraint handling, and the final output is deterministic so a changed rule creates a visible regression.

## Interview explanation target

Explain social graph candidate generation using Ada and the exact items in this folder, then describe why the broken output is wrong before discussing trade-offs.
