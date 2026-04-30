# Debugging Notes

The broken behavior is realistic because it passes a superficial smoke check but fails when the proof names the unsafe row or write. Fix: Add JSONB shape checks and project typed values before filtering.
