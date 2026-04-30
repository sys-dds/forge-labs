SET search_path TO bip_sql_017;
CREATE TABLE bookings (booking_id integer PRIMARY KEY, booked_at date NOT NULL, status text NOT NULL);
