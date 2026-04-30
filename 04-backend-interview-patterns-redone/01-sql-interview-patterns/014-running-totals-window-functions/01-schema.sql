SET search_path TO bip_sql_014;
CREATE TABLE ledger_entries (ledger_entry_id integer PRIMARY KEY, wallet_id integer NOT NULL, amount_pence integer NOT NULL, status text NOT NULL, posted_at timestamp NOT NULL);
