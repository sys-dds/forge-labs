# Debugging Notes

expected social graph candidates [101 close_friend,401 shared_group,501 commented_by_following]; broken generator leaked Cy 201, Noor 301, Theo 601, missed Diya 401, or duplicated Lina 501.

Ben post 101, Cy post 201, Noor post 301, Diya post 401, Lina post 501, Theo post 601 are the fastest rows to inspect when the proof fails. Cy post 201 proves a valid item survives. Noor post 301 and Diya post 401 show the broken output. Theo post 601 protects the final page shape.

The broken simulation is intentionally small so the wrong output can be read directly. Compare the returned IDs with the dataset before reading the solution.
