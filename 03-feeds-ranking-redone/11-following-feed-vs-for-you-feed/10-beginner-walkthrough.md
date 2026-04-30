# Beginner Walkthrough

- Product surface: following feed and For You feed.
- User expectation: Following is mostly chronological followed content; For You mixes recommendations and exploration.
- Broken behavior: Broken uses one output for both surfaces and leaks excluded items.
- Corrected behavior: following_feed [101,401,102], for_you_feed [101,501,401,701,102].
- Rows proving the lesson: following [101,401,102], for_you [101,501,401,701,102] and rejected 201/301/801.
- Tiny calculation: one candidate receives a positive signal, one receives a penalty, and the final order changes because the surface-specific score uses both.
