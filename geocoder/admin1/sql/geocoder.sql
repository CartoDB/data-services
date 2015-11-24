--Text array, country text

--- Usage

--- SELECT (geocode_admin1_polygons(Array['az', 'Texas'], 'Ecuador')).*


--- Function
CREATE OR REPLACE FUNCTION geocode_admin1_polygons(name text[], inputcountry text)
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

CREATE OR REPLACE FUNCTION geocode_admin1_polygons(names text[], country text[])
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

--Text text


--- Function

CREATE OR REPLACE FUNCTION geocode_admin1_polygons(name text[])
RETURNS SETOF geocode_admin_country_v1 AS $$
DECLARE 
    ret geocode_admin_v1%rowtype;
  BEGIN  RETURN QUERY
    SELECT d.q, n.the_geom as geom, CASE WHEN s.adm1_code IS NULL then FALSE ELSE TRUE END AS success FROM (SELECT q, lower(regexp_replace(q, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text x FROM (SELECT unnest(name) q) g) d LEFT OUTER JOIN admin1_synonyms s ON name_ = d.x LEFT OUTER JOIN ne_admin1_v3 n ON s.adm1_code = n.adm1_code;
END
$$ LANGUAGE 'plpgsql';


--Text array, country array --


--- Function ---

CREATE OR REPLACE FUNCTION geocode_admin_country_v1(names text[], country text[])
RETURNS SETOF geocode_admin_country_v1 AS $$
DECLARE 
    ret geocode_admin_country_v1%rowtype;
    nans TEXT[];
  BEGIN


  SELECT array_agg(p) INTO nans FROM (SELECT unnest(names) p, unnest(country) c) g WHERE c IS NULL;

  IF 0 < array_length(nans, 1) THEN
    SELECT array_agg(p), array_agg(c) INTO names, country FROM (SELECT unnest(names) p, unnest(country) c) g WHERE c IS NOT NULL;
    FOR ret IN SELECT g.q, NULL as c, g.geom, g.success FROM (SELECT (geocode_admin1_polygons(nans)).*) g LOOP
      RETURN NEXT ret;
    END LOOP;
  END IF;


  FOR ret IN WITH 
    p AS (SELECT r.p, r.q, c, (SELECT iso3 FROM country_decoder WHERE lower(r.c) = ANY (synonyms)) i FROM (SELECT  trim(replace(lower(unnest(names)),'.',' ')) p, unnest(names) q, unnest(country) c) r)
    SELECT
       q, c, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
    FROM (
      SELECT 
        q, c, (
          SELECT the_geom 
          FROM global_province_polygons
          WHERE p.p = ANY (synonyms) 
          AND iso3 = p.i
          -- To calculate frequency, I simply counted the number of users
          -- we had signed up in each country. Countries with more users, 
          -- we favor higher in the geocoder :)
          ORDER BY frequency DESC LIMIT 1
        ) geom
      FROM p) n
    LOOP
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql';

--Text array --


--- Function ---
CREATE OR REPLACE FUNCTION geocode_admin_country_v1(name text[])
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
          FROM global_province_polygons
          WHERE d.c = ANY (synonyms) 
          ORDER BY frequency DESC LIMIT 1
        ) geom
      FROM (SELECT trim(replace(lower(unnest(name)),'.',' ')) c, unnest(name) q) d
    ) v
  LOOP 
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql';

--Text array, country text--


--- Function ---
CREATE OR REPLACE FUNCTION geocode_admin_country_v1(name text[], inputcountry text)
RETURNS SETOF geocode_admin_v1 AS $$
 DECLARE 
    ret geocode_admin_v1%rowtype;
  BEGIN

  FOR ret IN WITH 
    p AS (SELECT r.c, r.q, (SELECT iso3 FROM country_decoder WHERE lower(inputcountry) = ANY (synonyms)) i FROM (SELECT  trim(replace(lower(unnest(name)),'.',' ')) c, unnest(name) q) r)
    SELECT
       q, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
    FROM (
      SELECT 
        q, (
          SELECT the_geom 
          FROM global_province_polygons
          WHERE p.c = ANY (synonyms) 
          AND iso3 = p.i
          -- To calculate frequency, I simply counted the number of users
          -- we had signed up in each country. Countries with more users, 
          -- we favor higher in the geocoder :)
          ORDER BY frequency DESC LIMIT 1
        ) geom
      FROM p) n
    LOOP
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql';

