# Clinic Format

Each clinic includes a broken simulation because feed bugs are easier to understand when the wrong ordered output is visible. Deterministic expected output matters because ranking changes can otherwise hide behind plausible scores. Every final item needs a reason label so the learner can answer why Ada saw it. Debugging needs traces and rejection reasons because final pages alone do not explain missing or removed items.

Future clinics should start with named rows, exact wrong output, and proof messages before adding code. Do not add broad folders or vague prose when one dataset and one proof can teach the rule.

## Hardened clinic standard
Each clinic keeps its behavior in clinic-local functions. Evidence maps and mutation checks are required so every named item is tied to a proof, trace, and drill. Shared helpers stay small and cannot contain clinic business rules.

## Part Two Clinic Files

New clinics include beginner walkthroughs, shortcut audits, and mutation checks. Each new clinic owns its broken simulation, solution, and proof file.


## Retrieval Slice

Clinics 01-10 cover feed pipeline foundations. Clinics 11-20 cover product surface ranking patterns. Clinics 21-30 cover evaluation, experiments, incidents, and senior design. Clinics 31-40 cover advanced retrieval, embeddings, ANN trade-offs, hybrid source blending, recall debugging, and retrieval system design. Stay on Feeds/Ranking Redone unless the user explicitly approves a track move. Future feed expansions can cover social graph/community algorithms, safety and trust ranking, and creator ecosystem depth.


## Graph Clinic Contract

Clinics 41-50 include graph candidates, missed graph candidates, rejected items, graph-specific semantic rows, graph_debug_trace, shortcut audit, mutation checks, and senior review notes.


## Safety Clinic Contract

Clinics 51-60 include policy decisions, evidence rows, rejected/downranked/informed/review rows, safety_debug_trace, audit logs where relevant, shortcut audit, mutation checks, and senior review notes.
## Creator And Marketplace Ecosystem Clinics

Clinics 01-10 cover feed pipeline foundations; 11-20 product surface ranking patterns; 21-30 evaluation, experiments, incidents, and senior design; 31-40 advanced retrieval, embeddings, ANN, and recall debugging; 41-50 social graph, communities, and graph algorithms; 51-60 safety, integrity, abuse, and trust ranking; 61-70 creator ecosystem and marketplace ranking depth. Stay on Feeds/Ranking Redone unless the user approves moving to another track. At clinic 70, Feeds/Ranking Redone is feature-complete unless review asks for another feed expansion.
