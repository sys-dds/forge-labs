# Debugging Notes

Swipes are directed decisions. Ada liking Ben and Ben liking Ada are two rows; together they derive the Ben mutual match.

Ada passed Cy while Cy liked Ada. PASS is not symmetric with LIKE, and it is not a weak LIKE. If PASS is treated as positive, Cy becomes a false match.

Ben is already handled by the mutual match path. Keeping Ben in `raw_candidates` would ask Ada to decide on someone she already liked.

Diya is active, but Ada blocked Diya. Exclusions are the first matching algorithm: blocked rows leave before interest or city checks happen.

Noor is inactive, so Noor cannot be a candidate even though Noor is otherwise a normal user row.

Maya and Omar are the raw candidates after exclusions. Maya shares `sql` and `backend` with Ada and fits Ada's London age preference. Omar remains a raw candidate but falls out of preference fit because he is 42 and in Paris.

