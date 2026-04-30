CREATE VIEW gauntlet_result AS SELECT id FROM audit_events WHERE payload->>'amount' > '20' OR payload ? 'reason';
