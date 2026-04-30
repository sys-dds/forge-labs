DO $$ DECLARE seen int; BEGIN
SET LOCAL ROLE forge_pg_writer; PERFORM set_config('app.workspace','alpha',true); SELECT count(*) INTO seen FROM tenant_notes; IF seen<>1 THEN RAISE EXCEPTION 'wrong read scope'; END IF;
BEGIN INSERT INTO tenant_notes VALUES (3,'beta','bad insert'); RAISE EXCEPTION 'wrong tenant insert accepted'; EXCEPTION WHEN insufficient_privilege OR check_violation THEN NULL; END;
BEGIN UPDATE tenant_notes SET workspace='beta' WHERE id=1; RAISE EXCEPTION 'cross tenant update accepted'; EXCEPTION WHEN insufficient_privilege OR check_violation THEN NULL; END;
RESET ROLE;
END $$;