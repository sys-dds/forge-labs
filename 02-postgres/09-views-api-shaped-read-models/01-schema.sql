CREATE TABLE sellers(id int PRIMARY KEY, handle text, email text);
CREATE TABLE listings(id int PRIMARY KEY, seller_id int, visible boolean);
CREATE TABLE reviews(id int PRIMARY KEY, seller_id int, verified boolean, deleted boolean);
CREATE TABLE disputes(id int PRIMARY KEY, seller_id int, status text);