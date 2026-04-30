# Scenario

Ada opens "People you may know."

The product should suggest accounts reached through people Ada already follows, but it must respect graph direction and safety exclusions. Ben and Cy are Ada's first-degree follows. Diya is a second-degree account reached through both Ben and Cy. Noor is also reachable through Cy, but Ada has blocked Noor. Theo exists to prove that disconnected users do not leak into the result.

The backend question:

```text
From Ada's outgoing follows, which second-degree followees are safe new suggestions?
```
