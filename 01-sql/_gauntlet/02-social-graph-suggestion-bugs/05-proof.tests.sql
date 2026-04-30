DO $$
DECLARE actual text[];
BEGIN
  SELECT array_agg(suggested_handle ORDER BY suggested_handle) INTO actual FROM gauntlet_result;
  IF actual IS DISTINCT FROM ARRAY['diya']::text[] THEN
    RAISE EXCEPTION 'expected only Diya, got %', actual;
  END IF;
  IF EXISTS (SELECT 1 FROM gauntlet_result WHERE suggested_handle IN ('ada','ben','cy','noor','theo')) THEN
    RAISE EXCEPTION 'self, followed, blocked, or disconnected user leaked';
  END IF;
END $$;
SELECT 'PASS social graph gauntlet' AS result;
