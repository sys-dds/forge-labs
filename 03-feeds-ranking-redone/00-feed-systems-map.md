# Feed Systems Map

A reusable feed pipeline is:

inventory -> eligibility -> candidate generation -> feature extraction -> scoring -> ranking -> filtering -> diversity/mixing -> pagination -> feedback -> evaluation

Inventory is everything the product could show. Eligibility removes blocked, muted, unsafe, expired, wrong-language, or user-controlled content before a score can rescue it. Candidate generation records why each item entered. Feature extraction makes score inputs visible. Scoring orders eligible items. Filtering and diversity shape the final page. Feedback and evaluation explain what happened and catch regressions.

## Surface-Specific Ranking

The same pipeline changes by surface: search starts from query relevance, marketplace starts from buyer intent, short video starts from watch signals, and safety can hard-filter, downrank, or route to review.


## Retrieval Slice

Clinics 01-10 cover feed pipeline foundations. Clinics 11-20 cover product surface ranking patterns. Clinics 21-30 cover evaluation, experiments, incidents, and senior design. Clinics 31-40 cover advanced retrieval, embeddings, ANN trade-offs, hybrid source blending, recall debugging, and retrieval system design. Stay on Feeds/Ranking Redone unless the user explicitly approves a track move. Future feed expansions can cover social graph/community algorithms, safety and trust ranking, and creator ecosystem depth.


## Graph Candidate Generation Layer

Clinics 41-50 place social graph retrieval before ranking: follow graph, mutuals, bipartite walks, random walks, authority, communities, heterogeneous paths, freshness, debug traces, and graph handoff.
