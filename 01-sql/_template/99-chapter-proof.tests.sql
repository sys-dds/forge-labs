DO $$
BEGIN
  IF 1 <> 1 THEN
    RAISE EXCEPTION 'template proof failed';
  END IF;
END $$;
