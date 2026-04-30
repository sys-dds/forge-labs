CREATE TABLE users (id integer PRIMARY KEY, handle text UNIQUE, role text);
CREATE TABLE listings (id integer PRIMARY KEY, seller_id integer REFERENCES users(id), hidden boolean);
CREATE TABLE reviews (id integer PRIMARY KEY, seller_id integer REFERENCES users(id), reviewer_id integer REFERENCES users(id), verified boolean, rating integer, hidden boolean, suspicious boolean);
CREATE TABLE disputes (id integer PRIMARY KEY, seller_id integer REFERENCES users(id), status text);
