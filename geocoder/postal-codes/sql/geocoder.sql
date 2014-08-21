--SELECT (geocode_postalcode_polygons(Array['10013','G9H','03782'], Array['USA', 'Canada', 'US'])).*

CREATE OR REPLACE FUNCTION geocode_postalcode_polygons(code text[], inputcountries text[])
  RETURNS SETOF geocode_namedplace_country_v1 AS $$
  DECLARE 
    ret geocode_namedplace_country_v1%rowtype;
  BEGIN
  FOR ret IN
    SELECT
      q, c, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
    FROM (
      SELECT 
        q, c, (
          SELECT the_geom
          FROM postal_code_polygons
          WHERE postal_code = upper(d.q)
            AND adm0_a3 = (
                  SELECT adm0_a3 FROM admin0_synonyms WHERE name_ = lower(regexp_replace(d.c, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text LIMIT 1
            )
        ) geom
      FROM (SELECT unnest(code) q, unnest(inputcountries) c) d
    ) v
  LOOP 
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;