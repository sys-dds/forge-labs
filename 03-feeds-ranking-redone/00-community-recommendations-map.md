# Community Recommendations Map

Clinics 41-50 add social graph and community-based candidate generation to the Feeds/Ranking Redone path.

- 41: data model with nodes, directed edges, undirected friendship, edge types, block and mute exclusions.
- 42: mutual friends and triangle closing with exact mutual counts.
- 43: bipartite user-item collaborative filtering with visible walk paths.
- 44: random-walk intuition using hand-calculated path probabilities.
- 45: PageRank-style authority propagation from trusted users and groups.
- 46: community and interest-cluster overlap, including hybrid items.
- 47: heterogeneous graph recommendations across events, newsletters, and posts.
- 48: edge freshness, decay, and interaction strength.
- 49: graph-stage missing-candidate debugging.
- 50: senior graph recommendation design with rich policies and handoff contract.

The handoff chain is: graph source -> path row -> graph score -> graph eligibility -> candidate pool -> ranking handoff.
