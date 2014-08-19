--SELECT (geocode_postalcode_polygons(Array['10013','11201','03782'], 'USA')).*;
--SELECT (geocode_postalcode_polygons(Array['10013','G9H','03782'], Array['USA', 'Canada', 'US'])).*


CREATE OR REPLACE FUNCTION test_geocode_postalcode_polygons(code text[], inputcountry text)
  RETURNS SETOF geocode_namedplace_v1 AS $$
  DECLARE 
  	c_iso3 text;
    ret geocode_namedplace_v1%rowtype;
  BEGIN
  	SELECT INTO c_iso3 adm0_a3 FROM admin0_synonyms WHERE name_ = lower(regexp_replace(c, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text LIMIT 1;
    FOR ret IN
      SELECT
        q, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
      FROM (
        SELECT 
          q, (
            SELECT the_geom 
            FROM postal_code_polygons
            WHERE postal_code = upper(d.q)
              AND adm0_a3 = c_iso3
          ) geom
        FROM (SELECT unnest(code) q) d
      ) v
      LOOP 
      RETURN NEXT ret;
    END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;


CREATE OR REPLACE FUNCTION test_geocode_postalcode_polygons(code text[], inputcountries text[])
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