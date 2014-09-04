--SELECT (geocode_postalcode_polygons(Array['10013','G9H','03782'], Array['USA', 'Canada', 'US'])).*

CREATE OR REPLACE FUNCTION geocode_postalcode_polygons(code text[], inputcountries text[])
  RETURNS SETOF geocode_namedplace_country_v1 AS $$
  DECLARE 
    ret geocode_namedplace_country_v1%rowtype;
    adm text[];
  BEGIN
  
  SELECT INTO adm array_agg((SELECT adm0_a3 FROM admin0_synonyms WHERE name_ = lower(regexp_replace(b.c, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text LIMIT 1)) FROM (SELECT UNNEST(inputcountries) c) b;

  FOR ret IN
    SELECT
      q, c, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
    FROM (
      SELECT 
        q, c, (
          SELECT the_geom
          FROM postal_code_polygons
          WHERE postal_code = CASE WHEN a = 'CAN' THEN substring(upper(d.q) from 1 for 3) ELSE upper(d.q) END
            AND adm0_a3 = a
        ) geom
      FROM (SELECT unnest(code) q, unnest(inputcountries) c, unnest(adm) a) d
    ) v
  LOOP 
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;