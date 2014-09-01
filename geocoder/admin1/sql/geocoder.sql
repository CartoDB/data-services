--- Usage

--- SELECT (geocode_admin1_polygons(Array['az', 'Texas'], 'Ecuador')).*


--- Function
CREATE OR REPLACE FUNCTION test_geocode_admin1_polygons(name text[], inputcountry text)
  RETURNS SETOF geocode_admin_country_v1 AS $$
  DECLARE 
    ret geocode_admin_country_v1%rowtype;
    adm0 TEXT;
    adm0_check BOOLEAN := TRUE;
  BEGIN

  IF inputcountry IS NULL THEN
    adm0_check = FALSE;
  END IF;
  IF trim(inputcountry)='' THEN
    adm0_check = FALSE;
  END IF;

  IF adm0_check IS TRUE THEN
    SELECT INTO adm0 adm0_a3 FROM admin0_synonyms WHERE name_ = lower(regexp_replace(inputcountry, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text LIMIT 1;

    FOR ret IN
      SELECT
        q, inputcountry, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
      FROM (
        SELECT 
          q, (
            SELECT the_geom FROM adm1 WHERE global_id = (
              SELECT global_id
              FROM admin1_synonyms
              WHERE name_ =  lower(regexp_replace(d.q, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text
                AND adm0_a3 = adm0
              LIMIT 1
              )
            ) geom
        FROM (SELECT unnest(name) q) d
      ) v
    LOOP 
      RETURN NEXT ret;
    END LOOP;

  --Handle cases where country couldn't be found
  ELSE
    FOR ret IN
      SELECT
        q, inputcountry, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
      FROM (
        SELECT 
          q, (
            SELECT the_geom FROM adm1 WHERE global_id = (
              SELECT global_id
              FROM admin1_synonyms
              WHERE name_ =  lower(regexp_replace(d.q, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text
              LIMIT 1
              )
            ) geom
        FROM (SELECT unnest(name) q) d
      ) v
    LOOP 
      RETURN NEXT ret;
    END LOOP;
  END IF;
  RETURN;
END
$$ LANGUAGE 'plpgsql';


--Text array, country array

--- Usage

--- SELECT (geocode_admin1_polygons(Array['az', 'az'], Array['Ecuador', 'USA'])).*

--- Function

CREATE OR REPLACE FUNCTION test_geocode_admin1_polygons(names text[], country text[])
  RETURNS SETOF geocode_admin_country_v1 AS $$
  DECLARE 
    ret geocode_admin_country_v1%rowtype;
  BEGIN

  FOR ret IN SELECT (test_geocode_admin1_polygons(array_agg(n), c)).* FROM (SELECT unnest(names) n, unnest(country) c) a GROUP BY c LOOP 
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql';

