# Debugging Notes

expected mixed page [101,501,601,701,901] with one Lina 501 carrying social_proof, similar_topic, trending; broken mixer duplicated 501 or lost reasons.

Ben post 101, Ben post 102, Lina post 501, Maya post 601, Omar post 701, Theo post 901 are the fastest rows to inspect when the proof fails. Ben post 102 proves a valid item survives. Lina post 501 and Maya post 601 show the broken output. Theo post 901 protects the final page shape.

The broken simulation is intentionally small so the wrong output can be read directly. Compare the returned IDs with the dataset before reading the solution.
