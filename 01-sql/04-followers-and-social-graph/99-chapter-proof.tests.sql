DO $$
DECLARE
  handles text[];
  cy_follow_count integer;
  theo_count integer;
BEGIN
  SELECT array_agg(handle ORDER BY handle) INTO handles FROM ada_following;
  IF handles <> ARRAY['ben','cy'] THEN
    RAISE EXCEPTION 'expected Ada following ben,cy got %', handles;
  END IF;

  SELECT array_agg(handle ORDER BY handle) INTO handles FROM ada_followers;
  IF handles <> ARRAY['ben','diya','noor'] THEN
    RAISE EXCEPTION 'expected Ada followers ben,diya,noor got %', handles;
  END IF;

  SELECT array_agg(handle ORDER BY handle) INTO handles FROM ada_mutual_follows;
  IF handles <> ARRAY['ben'] THEN
    RAISE EXCEPTION 'expected Ada mutual follows ben got %', handles;
  END IF;

  SELECT array_agg(handle ORDER BY handle) INTO handles FROM ada_follow_suggestions;
  IF handles <> ARRAY['diya'] THEN
    RAISE EXCEPTION 'expected Ada suggestions only diya got %', handles;
  END IF;

  SELECT array_agg(handle ORDER BY handle) INTO handles FROM ada_feed_visible_following;
  IF handles <> ARRAY['ben'] THEN
    RAISE EXCEPTION 'expected feed-visible following only ben got %', handles;
  END IF;

  SELECT count(*) INTO cy_follow_count FROM follows WHERE follower_id = 1 AND followee_id = 3;
  IF cy_follow_count <> 1 THEN
    RAISE EXCEPTION 'Ada -> Cy follow should remain even though Cy is muted';
  END IF;

  SELECT count(*) INTO theo_count FROM ada_social_graph_capstone WHERE handle = 'theo';
  IF theo_count <> 0 THEN
    RAISE EXCEPTION 'disconnected Theo should not appear in graph outputs';
  END IF;
END $$;

