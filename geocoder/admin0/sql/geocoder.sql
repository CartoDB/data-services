CREATE OR REPLACE FUNCTION test_geocode_admin0_polygons(name text[])
  RETURNS SETOF geocode_admin_v1 AS $$
  DECLARE 
    ret geocode_admin_v1%rowtype;
  BEGIN
  FOR ret IN
    SELECT
       q, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
    FROM (
      SELECT 
        q, (
          SELECT the_geom 
          FROM ne_admin0_v3
          WHERE adm0_a3 = (
            SELECT adm0_a3 FROM admin0_synonyms
            WHERE name_ = lower(regexp_replace(d.q, '[^a-zA-Z]', '', 'g'))  
            ORDER BY rank ASC LIMIT 1
          )
        ) geom
      FROM (SELECT unnest(name) q) d
    ) v
  LOOP 
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;