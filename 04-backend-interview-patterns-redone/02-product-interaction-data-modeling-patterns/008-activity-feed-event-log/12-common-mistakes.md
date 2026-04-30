# Common Mistakes

- Treating audit events as user-visible activity.
- Missing trap rows: Ada sees Ben public event 8001 and Diya followers event 8003, cannot see Ben private 8002; Ben sees his own private 8002; Cy is blocked from Ben event 8001; deleted post event 8004 is hidden.
- Forgetting owner-private visibility.
