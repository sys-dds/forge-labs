SET search_path TO bip_sql_021;
CREATE TABLE categories(category_id int PRIMARY KEY, category_name text NOT NULL, parent_category_id int, active boolean NOT NULL);
