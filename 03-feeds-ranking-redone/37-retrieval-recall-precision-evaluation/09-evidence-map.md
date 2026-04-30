# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| Relevant items 101 201 301 401 501 | ground truth for recall | Proof asserts exact recall denominators | Debug trace must mention relevant set | Drill changes relevance labels |
| Strategy A retrieved 10 | high recall low precision strategy | Proof asserts recall 1.0 precision 0.5 | Debug trace must mention Strategy A recall-first | Drill changes false positives |
| Strategy B retrieved 3 | high precision low recall strategy | Proof asserts recall 0.6 precision 1.0 | Debug trace must mention Strategy B false negatives | Drill changes false negatives |
| 401 relevant missed by B | first-stage recall risk | Proof asserts B false negative 401 | Debug trace must mention 401 false_negative | Drill changes recall miss |
| 501 relevant missed by B | second recall risk | Proof asserts B false negative 501 | Debug trace must mention 501 false_negative | Drill changes recall miss |
| 701 junk in A | precision cost after recall protected | Proof asserts A false positive includes 701 | Debug trace must mention 701 false_positive | Drill changes precision |
