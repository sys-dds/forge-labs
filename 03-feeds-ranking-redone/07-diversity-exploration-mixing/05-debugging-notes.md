# Debugging Notes

expected diverse feed [101,102,601,701,901]; broken ranker returned unsafe 1001, repeated Ben four times, overfilled backend, or omitted exploration 901.

Ben post 101, Ben post 102, Ben post 103, Maya post 601, Diya post 701, New creator 901 are the fastest rows to inspect when the proof fails. Ben post 102 proves a valid item survives. Ben post 103 and Maya post 601 show the broken output. Unsafe item 1001 protects the final page shape.

The broken simulation is intentionally small so the wrong output can be read directly. Compare the returned IDs with the dataset before reading the solution.
