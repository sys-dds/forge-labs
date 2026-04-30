# How To Study

1. Read the scenario.
2. Inspect the dataset.
3. Run the broken simulation proof.
4. Read the failure.
5. Inspect debugging notes.
6. Run the solution proof.
7. Change one scoring rule.
8. Rerun the proof.
9. Explain the ranking behavior out loud with item IDs and reasons.

## After hardening
When studying a clinic, read `10-mutation-checks.md` after the proof. Pick one mutation, make the change locally, and confirm the proof fails for the named reason before restoring it.

## Studying Part Two

For clinics 11-20, read the beginner walkthrough before the proof. Then inspect the shortcut audit and mutation checks so the lesson is tied to a product surface, not a reusable dispatcher.


## Retrieval Slice

Clinics 01-10 cover feed pipeline foundations. Clinics 11-20 cover product surface ranking patterns. Clinics 21-30 cover evaluation, experiments, incidents, and senior design. Clinics 31-40 cover advanced retrieval, embeddings, ANN trade-offs, hybrid source blending, recall debugging, and retrieval system design. Stay on Feeds/Ranking Redone unless the user explicitly approves a track move. Future feed expansions can cover social graph/community algorithms, safety and trust ranking, and creator ecosystem depth.


## Studying 41-50

For each graph clinic, name the nodes, draw the source path, inspect rejected and missed rows, then run the broken and solution proofs.


## Studying 51-60

For each safety clinic, identify the risk row, map it to remove/reduce/inform/review/allow, inspect audit trace, then run broken and solution proofs.
## Creator And Marketplace Ecosystem Clinics

Clinics 01-10 cover feed pipeline foundations; 11-20 product surface ranking patterns; 21-30 evaluation, experiments, incidents, and senior design; 31-40 advanced retrieval, embeddings, ANN, and recall debugging; 41-50 social graph, communities, and graph algorithms; 51-60 safety, integrity, abuse, and trust ranking; 61-70 creator ecosystem and marketplace ranking depth. Stay on Feeds/Ranking Redone unless the user approves moving to another track. At clinic 70, Feeds/Ranking Redone is feature-complete unless review asks for another feed expansion.
