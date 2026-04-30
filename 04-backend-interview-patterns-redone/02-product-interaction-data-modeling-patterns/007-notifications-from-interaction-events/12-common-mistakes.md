# Common Mistakes

- Emitting one notification per raw event.
- Missing trap rows: event 1001 Ben likes Ada post 201, 1002 Cy comments, 1003 Eli follows Ada, 1004 Diya matches Ada, 1005 is Ada self-like, and 1006 duplicates Ben like; notification 9001 is read.
- Counting read rows in unread counts.
