# Common Mistakes

- Building one raw joined view that leaks private, blocked, deleted, or inactive data.
- Missing trap rows: Ada sees Ben/Diya/Eli profiles, not Cy who blocked Ada or inactive Fay; home feed has Ben post 1001, variant also Eli post 1003; post 1001 counts only live reactions/comments; Ada/Diya match 5001 is active; unread notifications change from two to three.
- Treating swipes as matches without canonical match lifecycle state.
