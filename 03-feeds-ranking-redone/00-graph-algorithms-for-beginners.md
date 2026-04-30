# Graph Algorithms For Beginners

## bipartite graph
Plain-English meaning: a graph with two kinds of nodes, often users and items.
Tiny example from clinics 41-50: clinic 43 walks Ada -> post_101 -> Ben -> post_401.
Common beginner mistake: recommending globally popular items without shared-item evidence.
How to debug it: print the user-item-user-item path.
What a senior engineer asks next: how many shared items are enough?

## collaborative filtering
Plain-English meaning: using similar users' interactions to find items Ada has not seen.
Tiny example from clinics 41-50: Ben and Diya both point Ada toward `post_401`.
Common beginner mistake: forgetting to remove blocked-author items.
How to debug it: log similar users, shared items, candidate item, and rejection reason.
What a senior engineer asks next: does popularity swamp personal overlap?

## random walk
Plain-English meaning: spreading probability through graph paths.
Tiny example from clinics 41-50: clinic 44 calculates `Ada -> Ben -> post_101` as `0.5 * 0.7 = 0.35`.
Common beginner mistake: counting paths instead of multiplying weights.
How to debug it: show every path probability row.
What a senior engineer asks next: how many hops are useful before noise dominates?

## authority
Plain-English meaning: trust or importance passed from a source node.
Tiny example from clinics 41-50: Ben and Diya pass more authority to `post_101` than Omar passes to `post_301`.
Common beginner mistake: treating a low-trust spammer like a trusted creator.
How to debug it: log source node and authority contribution.
What a senior engineer asks next: how is source trust calibrated?

## propagation
Plain-English meaning: moving a score from one node to another along an edge.
Tiny example from clinics 41-50: Backend Club gives club authority to `post_201`.
Common beginner mistake: hiding which node supplied the score.
How to debug it: inspect authority rows with source nodes.
What a senior engineer asks next: how do we stop bad authority from spreading?

## PageRank-style scoring
Plain-English meaning: a small mental model for authority flowing through links.
Tiny example from clinics 41-50: post_101 receives 0.9 from Ben and 0.9 from Diya, totaling 1.8.
Common beginner mistake: saying PageRank when only share count is used.
How to debug it: compare share count with weighted source authority.
What a senior engineer asks next: does the source graph resist spam loops?

## community
Plain-English meaning: a cluster of users or items with shared interest.
Tiny example from clinics 41-50: Ada has backend strength 0.9 and movie strength 0.3.
Common beginner mistake: forcing each item into only one cluster.
How to debug it: print membership strengths per cluster.
What a senior engineer asks next: how often are clusters refreshed?

## interest cluster
Plain-English meaning: a named community signal such as backend, movie, or cooking.
Tiny example from clinics 41-50: `post_201` is backend 0.6 and movie 0.5.
Common beginner mistake: dropping hybrid items.
How to debug it: compute overlap parts for each cluster.
What a senior engineer asks next: are clusters explainable enough for review?

## heterogeneous graph
Plain-English meaning: a graph with many node types.
Tiny example from clinics 41-50: Ada reaches `javaconf` through Backend Club and `backend_newsletter` through a company.
Common beginner mistake: returning only posts.
How to debug it: print candidate node type and path.
What a senior engineer asks next: what quotas protect each node type?
