CREATE TABLE sellers(id int PRIMARY KEY, handle text);
CREATE TABLE reviews(id int PRIMARY KEY, seller_id int, verified boolean, deleted boolean);