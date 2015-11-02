--
-- Name: test_geocode_admin0_polygons(text[]); Type: FUNCTION; Schema: public; Owner: cartodb_user_256c8c82-e93c-486d-b17d-c9d6b40009a0
--
CREATE FUNCTION test_geocode_postalcode_polygons(code text[], inputcountry text) RETURNS SETOF geocode_namedplace_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
  DECLARE 
  	c text;
  	c_iso3 text;
    ret geocode_namedplace_v1%rowtype;
  BEGIN
  	c := inputcountry;

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
$$;


--
-- Name: test_geocode_admin0_polygons(text[]); Type: FUNCTION; Schema: public; Owner: cartodb_user_256c8c82-e93c-486d-b17d-c9d6b40009a0
--
CREATE FUNCTION test_geocode_postalcode_polygons(code text[], inputcountries text[]) RETURNS SETOF geocode_namedplace_country_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
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
$$;

--
-- Not a test_* function. This function is the old version from which we changed the table being used to the global* one.
-- Name: geocode_postalcode_polygons_deprec(text[], text[]); Type: FUNCTION; Schema: public; Owner: cartodb_user_256c8c82-e93c-486d-b17d-c9d6b40009a0
--

CREATE FUNCTION geocode_postalcode_polygons_deprec(code text[], inputcountries text[]) RETURNS SETOF geocode_namedplace_country_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
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
$$;




--
-- Name: geocode_postalcode_points_dev(text[], text[]); Type: FUNCTION; Schema: public; Owner: cartodb_user_256c8c82-e93c-486d-b17d-c9d6b40009a0
--



CREATE FUNCTION geocode_postalcode_points_dev(code text[], inputcountries text[]) RETURNS SETOF geocode_place_country_iso_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
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
$$;