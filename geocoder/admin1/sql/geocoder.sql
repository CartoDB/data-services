--- Usage

--- SELECT (geocode_admin1_polygons(Array['az', 'az'], Array['Ecuador', 'USA'])).*

--- Function

CREATE OR REPLACE FUNCTION geocode_admin1_polygons(names text[], country text[])
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
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;
