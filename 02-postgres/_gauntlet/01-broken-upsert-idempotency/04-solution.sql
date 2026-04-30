DROP INDEX IF EXISTS broken_global_idem;
INSERT INTO create_requests(actor,idem_key,immutable_payload,status) VALUES ('ada','create-1','listing=10','processed') ON CONFLICT (actor,idem_key) DO UPDATE SET status=EXCLUDED.status;
INSERT INTO create_requests(actor,idem_key,immutable_payload,status) VALUES ('ben','create-1','listing=20','received') ON CONFLICT (actor,idem_key) DO NOTHING;
CREATE VIEW gauntlet_result AS SELECT actor, idem_key, immutable_payload, status FROM create_requests;