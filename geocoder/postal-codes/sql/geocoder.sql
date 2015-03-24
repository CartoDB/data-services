-- Usage

--SELECT (geocode_postalcode_polygons(Array['10013','11201','03782'], 'USA')).*;

-- Function

CREATE OR REPLACE FUNCTION geocode_postalcode_polygons(code text[], inputcountry text)
  RETURNS SETOF geocode_namedplace_v1 AS $$
  DECLARE 
    ret geocode_namedplace_v1%rowtype;
  BEGIN
  FOR ret IN
    SELECT
      q, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
    FROM (
      SELECT 
        q, (
          SELECT the_geom 
          FROM global_postal_code_polygons
          WHERE postal_code = upper(d.q)
            AND iso3 = (
                SELECT iso3 FROM country_decoder WHERE
                lower(inputcountry) = ANY (synonyms) LIMIT 1
            )
        ) geom
      FROM (SELECT unnest(code) q) d
    ) v
  LOOP 
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;


-- Text array, country array

-- Usage
--SELECT (geocode_postalcode_polygons(Array['10013','G9H','03782'], Array['USA', 'Canada', 'US'])).*


-- Function


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
          FROM global_postal_code_polygons
          WHERE postal_code = upper(d.q)
            AND iso3 = (
                SELECT iso3 FROM country_decoder WHERE
                lower(d.c) = ANY (synonyms) LIMIT 1
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




-- Int array, country array

-- Usage
--SELECT (geocode_postalcode_polygons(Array[10013, 3782, 80002], Array['USA'])).*


--- Function

CREATE OR REPLACE FUNCTION geocode_postalcode_polygons(code int[], inputcountries text[])
RETURNS SETOF geocode_postalint_country_v1 AS $$
DECLARE 
  ret geocode_postalint_country_v1%rowtype;
BEGIN
  FOR ret IN
    SELECT
      q, c, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
    FROM (
      SELECT 
        q, c, (
          SELECT the_geom
          FROM global_postal_code_polygons
          WHERE postal_code_num = d.q
            AND iso3 = (
                SELECT iso3 FROM country_decoder WHERE
                lower(d.c) = ANY (synonyms) LIMIT 1
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

-- Postal code points

-- Usage
--SELECT (geocode_postalcode_points(Array['10013','11201','03782'])).*

-- Function

CREATE OR REPLACE FUNCTION geocode_postalcode_points(code text[])
  RETURNS SETOF geocode_namedplace_v1 AS $$
  DECLARE 
    ret geocode_namedplace_v1%rowtype;
  BEGIN
  FOR ret IN
    SELECT
      q, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
    FROM (
      SELECT 
        q, (
          SELECT the_geom 
          FROM global_postal_code_points
          WHERE postal_code = upper(d.q) 
          LIMIT 1
        ) geom
      FROM (SELECT unnest(code) q) d
    ) v
  LOOP 
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;

--Text array, country string
-- Usage

--SELECT (geocode_postalcode_points(Array['10013','11201','03782'], 'USA')).*


-- Function

CREATE OR REPLACE FUNCTION geocode_postalcode_points(code text[], inputcountry text)
  RETURNS SETOF geocode_namedplace_v1 AS $$
  DECLARE 
    ret geocode_namedplace_v1%rowtype;
  BEGIN
  FOR ret IN
    SELECT
      q, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
    FROM (
      SELECT 
        q, (
          SELECT the_geom 
          FROM global_postal_code_points
          WHERE postal_code = upper(d.q)
            AND iso3 = (
                SELECT iso3 FROM country_decoder WHERE
                lower(inputcountry) = ANY (synonyms) LIMIT 1
            )
          LIMIT 1
        ) geom
      FROM (SELECT unnest(code) q) d
    ) v
  LOOP 
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;

-- Text array, country array

-- Usage
--SELECT (geocode_postalcode_points(Array['10013','G9H','03782'], Array['USA', 'Canada', 'US'])).*

-- Function

CREATE OR REPLACE FUNCTION geocode_postalcode_points(code text[], inputcountries text[])
  RETURNS SETOF geocode_place_country_iso_v1 AS $$
  DECLARE 
    ret geocode_place_country_iso_v1%rowtype;
    geo GEOMETRY;
  BEGIN

  FOR ret IN
    SELECT
      q, c, iso3, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
    FROM (
      SELECT 
        q, c, (SELECT iso3 FROM country_decoder WHERE
                lower(d.c) = ANY (synonyms) LIMIT 1) iso3, (
          SELECT the_geom
          FROM global_postal_code_points
          WHERE postal_code = upper(d.q)
            AND iso3 = (
                SELECT iso3 FROM country_decoder WHERE
                lower(d.c) = ANY (synonyms) LIMIT 1
            )
          LIMIT 1
        ) geom
      FROM (SELECT unnest(code) q, unnest(inputcountries) c) d
    ) v
  LOOP 
    IF ret.geom IS NULL AND ret.iso3 = 'GBR' THEN
      geo := geocode_greatbritain_outward(ret.q);
      IF geo IS NOT NULL THEN
        ret.geom := geo;
        ret.success := TRUE;
      END IF;
    END IF;
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;

-- Great Britain helper function

CREATE OR REPLACE FUNCTION geocode_greatbritain_outward(code text)
  RETURNS geometry AS $$
  DECLARE
    geom GEOMETRY;
  BEGIN
  code := trim(code);
  geom := NULL;
  IF array_length(string_to_array(code,' '),1) = 2 THEN
    code := split_part(code, ' ', 1) || ' ' || rpad(substring(split_part(code, ' ', 2), 1, 1), 3, '#');
    SELECT the_geom INTO geom FROM global_postal_code_points WHERE 
      postal_code = code
      AND iso3 = 'GBR'
      LIMIT 1;
  END IF;
  RETURN geom;
END
$$ LANGUAGE 'plpgsql';

-- Int array, country array

-- Usage
--SELECT (geocode_postalcode_points(Array[10013, 11201,03782], Array['USA', 'USA', 'USA'])).*


-- Function

CREATE OR REPLACE FUNCTION geocode_postalcode_points(code int[], inputcountries text[])
  RETURNS SETOF geocode_postalint_country_v1 AS $$
  DECLARE 
    ret geocode_postalint_country_v1%rowtype;
  BEGIN
  FOR ret IN
    SELECT
      q, c, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
    FROM (
      SELECT 
        q, c, (
          SELECT the_geom
          FROM global_postal_code_points
          WHERE postal_code_num = d.q
            AND iso3 = (
                SELECT iso3 FROM country_decoder WHERE
                lower(d.c) = ANY (synonyms) LIMIT 1
            )
          LIMIT 1
        ) geom
      FROM (SELECT unnest(code) q, unnest(inputcountries) c) d
    ) v
  LOOP 
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;
