# Advisory Lock Misuse

A worker takes a lock but does not transition the job row, so another path can treat it as queued.
