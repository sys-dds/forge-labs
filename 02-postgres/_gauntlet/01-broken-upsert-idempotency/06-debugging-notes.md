# Debugging Notes

The broken behavior is realistic because it passes a superficial smoke check but fails when the proof names the unsafe row or write. Fix: Use `(actor, idem_key)` as the conflict target and avoid overwriting immutable payloads.
