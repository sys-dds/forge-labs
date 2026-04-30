DO $$ DECLARE unqualified text; BEGIN
IF NOT EXISTS (SELECT 1 FROM namespace_result WHERE app_handle='Ada' AND normalized='ada' AND audit_count=1) THEN RAISE EXCEPTION 'qualified namespace result wrong'; END IF;
SET LOCAL search_path=demo,app,public; SELECT handle INTO unqualified FROM users WHERE id=1; IF unqualified <> 'Wrong Ada' THEN RAISE EXCEPTION 'search_path demonstration wrong'; END IF;
END $$;