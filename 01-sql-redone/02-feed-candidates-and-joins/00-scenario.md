# Scenario

Ada follows Ben, Cy, and Noor. Ada also muted Cy and blocked Noor. The feed should contain only visible posts from followed authors after block and mute exclusions run.

The broken query joins directly to comments, forgets the safety exclusions, and forgets the hidden-post filter. That makes Cy post 201 and Noor post 301 appear, drops Ben post 102 because it has no comments, and allows hidden Ben post 103.

