# Break Fix Drills

1. Change mutual matches to accept `decision IN ('LIKE', 'PASS')`; Cy should become a false Ada match.
2. Remove the already-swiped exclusion; Ben and Cy should return as raw candidates.
3. Remove the block exclusion; Diya should return even though Ada blocked Diya.
4. Remove the active-user filter; Noor should return as a candidate.
5. Apply preference fit before exclusions and inspect Diya; a city/age match must not rescue a blocked row.

