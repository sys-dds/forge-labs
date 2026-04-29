-- Capstone: one public row that a profile endpoint could safely return.
CREATE VIEW profile_query_capstone AS SELECT * FROM profile_card_with_counts;
