# Debugging Notes

Ada following Ben, Cy, and Maya uses outgoing edges where Ada is `follower_id`. Reversing that direction reads Ada's followers instead.

Ben follows Ada back, so Ben is the only mutual. Cy is followed by Ada but does not follow Ada, which proves an outgoing edge alone is not a mutual follow.

Diya is reachable through Ben, Cy, and Maya. Those three raw paths are useful, but `ada_safe_suggestions` must collapse Diya to one suggestion row.

Noor is reachable through Cy, but Ada blocks Noor. DISTINCT would remove duplicate Noor rows if they existed, but it would not make Noor safe.

Omar follows Ada. That incoming edge makes Omar a follower, not a second-degree outgoing suggestion.

Theo has no edge at all. If Theo appears, the query stopped using graph traversal and became table browsing.

