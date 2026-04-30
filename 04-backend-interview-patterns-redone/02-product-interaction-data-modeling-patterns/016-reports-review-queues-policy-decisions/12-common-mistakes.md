# Common Mistakes

- Treating reports as decisions instead of evidence.
- Missing named safety rows: reports 1001 and 1002 both target post 201 and group into queue item 3001, report 1003 on post 202 is low quality and allowed in decision 4002, evidence rows 2001 and 2002 link to spam decision 4001, and treatment 5001 hides post 201.
- Returning a boolean or opaque score without decision reasons, treatments, or components.
