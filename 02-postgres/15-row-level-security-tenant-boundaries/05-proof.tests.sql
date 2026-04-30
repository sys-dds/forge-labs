DO $$ DECLARE alpha_count int; beta_count int; none_count int; BEGIN
SET LOCAL ROLE forge_pg_app_user; PERFORM set_config('app.workspace','alpha',true); SELECT count(*) INTO alpha_count FROM tenant_listings; PERFORM set_config('app.workspace','beta',true); SELECT count(*) INTO beta_count FROM tenant_listings; PERFORM set_config('app.workspace','',true); SELECT count(*) INTO none_count FROM tenant_listings; RESET ROLE;
IF alpha_count<>1 OR beta_count<>1 OR none_count<>0 THEN RAISE EXCEPTION 'RLS tenant boundary wrong: %, %, %', alpha_count,beta_count,none_count; END IF;
END $$;