# Debugging Notes

expected final feed [101,501,601,901]; broken replay returned blocked Noor 701, repeated Ben 101/102/103, or omitted exploration 901.

Ben post 101, Ben post 102, Ben post 103, Lina post 501, Maya post 601, Noor post 701 are the fastest rows to inspect when the proof fails. Ben post 102 proves a valid item survives. Ben post 103 and Lina post 501 show the broken output. New creator 901 protects the final page shape.

The broken simulation is intentionally small so the wrong output can be read directly. Compare the returned IDs with the dataset before reading the solution.
