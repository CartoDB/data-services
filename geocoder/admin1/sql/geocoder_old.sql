--
-- Name: test_geocode_admin0_polygons(text[]); Type: FUNCTION; Schema: public; Owner: cartodb_user_256c8c82-e93c-486d-b17d-c9d6b40009a0
--
CREATE FUNCTION test_geocode_admin1_polygons(names text[], country text[]) RETURNS SETOF geocode_admin_country_v1
    LANGUAGE plpgsql
    AS $$
  DECLARE 
    ret geocode_admin_country_v1%rowtype;
  BEGIN

  FOR ret IN SELECT (test_geocode_admin1_polygons(array_agg(n), c)).* FROM (SELECT unnest(names) n, unnest(country) c) a GROUP BY c LOOP 
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$;


--
-- Name: test_geocode_admin0_polygons(text[]); Type: FUNCTION; Schema: public; Owner: cartodb_user_256c8c82-e93c-486d-b17d-c9d6b40009a0
--

CREATE FUNCTION test_geocode_admin1_polygons(name text[], inputcountry text) RETURNS SETOF geocode_admin_country_v1
    LANGUAGE plpgsql
    AS $$
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
    END LOOP;  ELSE
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
$$;

--
-- Name: test_geocode_admin0_polygons(text[]); Type: FUNCTION; Schema: public; Owner: cartodb_user_256c8c82-e93c-486d-b17d-c9d6b40009a0
--

CREATE FUNCTION test_geocode_admin1_polygons(name text[]) RETURNS SETOF geocode_admin_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
  DECLARE 
    ret geocode_admin_v1%rowtype;
  BEGIN  RETURN QUERY
    SELECT d.q, n.the_geom as geom, CASE WHEN s.adm1_code IS NULL then FALSE ELSE TRUE END AS success FROM (SELECT q, lower(regexp_replace(q, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text x FROM (SELECT unnest(name) q) g) d LEFT OUTER JOIN admin1_synonyms s ON name_ = d.x LEFT OUTER JOIN ne_admin1_v3 n ON s.adm1_code = n.adm1_code;
END
$$;
