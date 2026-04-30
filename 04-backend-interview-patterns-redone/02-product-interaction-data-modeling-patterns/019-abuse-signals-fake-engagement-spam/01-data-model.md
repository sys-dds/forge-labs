# Data Model

## Actual tables

`users, posts, post_reactions, comments, follow_edges, report_events, abuse_signal_events, abuse_signal_evidence, policy_treatments`.

## Trap rows

Cy user 3 repeats duplicate comments 301/302/303 creating spam signal 7001, Ben user 2 has like burst signal 7002 on post 201, Diya user 4 has normal engagement and no signal, report 6001 plus evidence rows 8001 and 8002 put Cy into review, and treatment 9001 reviews Cy while treatment 9002 allows Diya.

## Constraints

Safety outputs must include evidence rows, treatment reasons, and debug traces rather than report-count shortcuts.

## Read contract

Join abuse_signal_events to abuse_signal_evidence and policy_treatments, distinguish duplicate comment and fake like burst evidence from normal engagement, and emit safety debug traces.
