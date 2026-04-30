# Debugging Notes

expected final feed [101,501,401,701]; broken ranker returned muted Cy 201, blocked Noor 301, or unsafe Omar 601 because it scored before eligibility.

Ada viewer, Ben post 101, Cy post 201, Noor post 301, Omar post 601, Maya post 701 are the fastest rows to inspect when the proof fails. Ben post 101 proves a valid item survives. Cy post 201 and Noor post 301 show the broken output. Maya post 701 protects the final page shape.

The broken simulation is intentionally small so the wrong output can be read directly. Compare the returned IDs with the dataset before reading the solution.
