# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Send duplicate Ben event | proof fails duplicate_notification rejection |
| Send Lina during quiet hours | proof fails quiet_hours rejection |
| Send Noor blocked notification | proof fails blocked_author rejection |
| Ignore fatigue cap | proof fails notification count cap |
| Ignore open probability for Omar | proof fails fatigue_or_low_open_probability rejection |
| Remove Ben debug trace | proof fails debug_trace assertion for ben_posted |
