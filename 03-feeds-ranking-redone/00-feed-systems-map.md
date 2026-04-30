# Feed Systems Map

A reusable feed pipeline is:

inventory -> eligibility -> candidate generation -> feature extraction -> scoring -> ranking -> filtering -> diversity/mixing -> pagination -> feedback -> evaluation

Inventory is everything the product could show. Eligibility removes blocked, muted, unsafe, expired, wrong-language, or user-controlled content before a score can rescue it. Candidate generation records why each item entered. Feature extraction makes score inputs visible. Scoring orders eligible items. Filtering and diversity shape the final page. Feedback and evaluation explain what happened and catch regressions.
