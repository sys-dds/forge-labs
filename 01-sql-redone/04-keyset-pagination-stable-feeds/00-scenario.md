# Scenario

Ada reads page one at size 2 and sees posts 107 and 106. Before she asks for page two, post 108 is inserted at the top.

Offset page two now starts after the new top two rows, so post 106 can appear again. A cursor based on the exact last seen row avoids that shift.

