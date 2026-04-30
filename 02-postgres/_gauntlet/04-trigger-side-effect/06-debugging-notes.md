# Debugging Notes

The broken behavior is realistic because it passes a superficial smoke check but fails when the proof names the unsafe row or write. Fix: Add a WHEN guard so only status changes are audited.
