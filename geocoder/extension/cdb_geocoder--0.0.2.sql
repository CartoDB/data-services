-- Response types for admin0 geocoder
CREATE TYPE geocode_admin_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE synonym_lookup_v1 AS (q TEXT, adm0_a3 TEXT);

-- Response types for admin1 geocoder
CREATE TYPE geocode_admin_country_v1 AS (q TEXT, c TEXT, geom GEOMETRY, success BOOLEAN);

-- Response types for IP addresses geocoder
CREATE TYPE geocode_ip_v1 AS (q text, geom geometry, success boolean);

-- Response types for namedplaces geocoder
CREATE TYPE geocode_namedplace_country_v1 AS (q TEXT, c TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_namedplace_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_admin1_country_v1 AS (q text, a1 text, c text, geom geometry, success boolean);

-- Response types for postalcodes geocoder
CREATE TYPE geocode_postalint_country_v1 AS (q INT, c TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_place_country_iso_v1 AS (q TEXT, c TEXT, iso3 TEXT, geom GEOMETRY, success BOOLEAN);


CREATE TYPE available_services_v1 AS (q text, adm0_a3 text, postal_code_points boolean, postal_code_polygons boolean);
-- Public API functions --
--- Geocoding function ---
-- TODO: deal with permissions
CREATE OR REPLACE FUNCTION geocode_admin1_polygons(name text[]) RETURNS SETOF geocode_admin_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
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
$$;


CREATE OR REPLACE FUNCTION geocode_admin1_polygons(name text[], inputcountry text) RETURNS SETOF geocode_admin_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
  DECLARE
    ret geocode_admin_v1%rowtype;
  BEGIN

  FOR ret IN WITH
    p AS (SELECT r.c, r.q, (SELECT iso3 FROM country_decoder WHERE lower(geocode_clean_name(inputcountry))::text = ANY (synonyms)) i FROM (SELECT  trim(replace(lower(unnest(name)),'.',' ')) c, unnest(name) q) r)
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
$$;


CREATE OR REPLACE FUNCTION geocode_admin1_polygons(names text[], country text[]) RETURNS SETOF geocode_admin_country_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
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
    p AS (SELECT r.p, r.q, c, (SELECT iso3 FROM country_decoder WHERE lower(geocode_clean_name(r.c))::text = ANY (synonyms)) i FROM (SELECT  trim(replace(lower(unnest(names)),'.',' ')) p, unnest(names) q, unnest(country) c) r)
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
$$;

--------------------------------------------------------------------------------

-- Support tables

CREATE TABLE global_province_polygons (
    the_geom geometry(Geometry,4326),
    adm1_code text,
    objectid_1 integer,
    diss_me integer,
    adm1_cod_1 text,
    iso_3166_2 text,
    wikipedia text,
    iso_a2 text,
    adm0_sr integer,
    name text,
    name_alt text,
    name_local text,
    type text,
    type_en text,
    code_local text,
    code_hasc text,
    note text,
    hasc_maybe text,
    region text,
    region_cod text,
    provnum_ne integer,
    gadm_level integer,
    check_me integer,
    scalerank integer,
    datarank integer,
    abbrev text,
    postal text,
    area_sqkm double precision,
    sameascity integer,
    labelrank integer,
    featurecla text,
    name_len integer,
    mapcolor9 integer,
    mapcolor13 integer,
    fips text,
    fips_alt text,
    woe_id integer,
    woe_label text,
    woe_name text,
    latitude double precision,
    longitude double precision,
    sov_a3 text,
    iso3 text,
    adm0_label integer,
    admin text,
    geonunit text,
    gu_a3 text,
    gn_id integer,
    gn_name text,
    gns_id integer,
    gns_name text,
    gn_level integer,
    gn_region text,
    gn_a1_code text,
    region_sub text,
    sub_code text,
    gns_level integer,
    gns_lang text,
    gns_adm1 text,
    gns_region text,
    cartodb_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom_webmercator geometry(Geometry,3857),
    synonyms text[],
    frequency double precision
);

CREATE SEQUENCE ne_10m_admin_1_states_provinces_cartodb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE ne_10m_admin_1_states_provinces_cartodb_id_seq OWNED BY global_province_polygons.cartodb_id;
ALTER TABLE ONLY global_province_polygons ALTER COLUMN cartodb_id SET DEFAULT nextval('ne_10m_admin_1_states_provinces_cartodb_id_seq'::regclass);
ALTER TABLE ONLY global_province_polygons
    ADD CONSTRAINT global_province_polygons_cartodb_id_key UNIQUE (cartodb_id);
ALTER TABLE ONLY global_province_polygons
    ADD CONSTRAINT global_province_polygons_pkey PRIMARY KEY (cartodb_id);

CREATE INDEX global_province_polygons_the_geom_idx ON global_province_polygons USING gist (the_geom);
CREATE INDEX global_province_polygons_the_geom_webmercator_idx ON global_province_polygons USING gist (the_geom_webmercator);

CREATE TRIGGER track_updates AFTER INSERT OR DELETE OR UPDATE OR TRUNCATE ON global_province_polygons FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_tablemetadata_trigger();
CREATE TRIGGER update_the_geom_webmercator_trigger BEFORE INSERT OR UPDATE OF the_geom ON global_province_polygons FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_the_geom_webmercator();
CREATE TRIGGER update_updated_at_trigger BEFORE UPDATE ON global_province_polygons FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_updated_at();
-- Public API functions --
--- Geocoding function ---
-- TODO: deal with permissions

CREATE OR REPLACE FUNCTION geocode_namedplace(places text[], country text[]) RETURNS SETOF geocode_namedplace_country_v1
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER
    AS $$
  DECLARE
    ret geocode_namedplace_country_v1%rowtype;
    nans TEXT[];
  BEGIN

  SELECT array_agg(p)  INTO nans FROM (SELECT unnest(places) p, unnest(country) c) g WHERE c IS NULL;

  IF 0 < array_length(nans, 1) THEN
    SELECT array_agg(p), array_agg(c) INTO places, country FROM (SELECT unnest(places) p, unnest(country) c) g WHERE c IS NOT NULL;
    FOR ret IN SELECT g.q, NULL as c, g.geom, g.success FROM (SELECT (geocode_namedplace(nans)).*) g LOOP
      RETURN NEXT ret;
    END LOOP;
  END IF;

  SELECT array_agg(p)  INTO nans FROM (SELECT unnest(places) p, unnest(country) c) g WHERE c='';
  IF 0 < array_length(nans, 1) THEN
    SELECT array_agg(p), array_agg(c) INTO places, country FROM (SELECT unnest(places) p, unnest(country) c) g WHERE c!='';
    FOR ret IN SELECT g.q, '' as c, g.geom, g.success FROM (SELECT (geocode_namedplace(nans)).*) g LOOP
      RETURN NEXT ret;
    END LOOP;
  END IF;

  FOR ret IN WITH
    p AS (SELECT r.s, r.c, (SELECT iso2 FROM country_decoder WHERE lower(geocode_clean_name(r.c))::text = ANY (synonyms)) i FROM (SELECT unnest(places) AS s, unnest(country)::text AS c) r),
    best AS (SELECT p.s AS q, p.c AS c, (SELECT gp.the_geom AS geom FROM global_cities_points_limited gp WHERE gp.lowername = lower(p.s) AND gp.iso2 = p.i ORDER BY population DESC LIMIT 1) AS geom FROM p),
    next AS (SELECT p.s AS q, p.c AS c, (SELECT gp.the_geom FROM global_cities_points_limited gp, global_cities_alternates_limited ga WHERE lower(p.s) = ga.lowername AND gp.iso2 = p.i AND ga.geoname_id = gp.geoname_id ORDER BY preferred DESC LIMIT 1) geom FROM p WHERE p.s NOT IN (SELECT q FROM best WHERE c = p.c AND geom IS NOT NULL))
    SELECT q, c, geom, TRUE AS success FROM best WHERE geom IS NOT NULL
    UNION ALL
    SELECT q, c, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success FROM next
    LOOP
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$;


CREATE OR REPLACE FUNCTION geocode_namedplace(places text[], inputcountry text) RETURNS SETOF geocode_admin_country_v1
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER
    AS $$
  DECLARE
    ret geocode_admin_country_v1%rowtype;
    isoTwo TEXT := NULL;
    has_country BOOLEAN;
  BEGIN
  has_country := TRUE;
  -- find the iso2 code for the input country string, else NULL
  IF inputcountry IS NULL THEN
    has_country := FALSE;
  ELSIF inputcountry = '' THEN
    has_country := FALSE;
  END IF;

  IF has_country THEN
    SELECT iso2 INTO isoTwo FROM country_decoder WHERE lower(geocode_clean_name(inputcountry))::text = ANY (synonyms) LIMIT 1;
    FOR ret IN WITH
      best AS (SELECT p.s AS q, (SELECT gp.the_geom AS geom FROM global_cities_points_limited gp WHERE gp.lowername = lower(p.s) AND gp.iso2 = isoTwo ORDER BY population DESC LIMIT 1) AS geom FROM (SELECT unnest(places) AS s) p),
      next AS (SELECT p.s AS q, (SELECT gp.the_geom FROM global_cities_points_limited gp, global_cities_alternates_limited ga WHERE lower(p.s) = ga.lowername AND gp.iso2 = isoTwo AND ga.geoname_id = gp.geoname_id ORDER BY preferred DESC LIMIT 1) geom FROM (SELECT unnest(places) AS s) p WHERE p.s NOT IN (SELECT q FROM best WHERE geom IS NOT NULL))
      SELECT q, inputcountry c, geom, TRUE AS success FROM best WHERE geom IS NOT NULL
      UNION ALL
      SELECT q, inputcountry c, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success FROM next
      LOOP
      RETURN NEXT ret;
    END LOOP;
  -- no country included, or iso interpretation found
  ELSE
    FOR ret IN
      SELECT g.q as q, inputcountry as c, g.geom as geom, g.success as success FROM (SELECT (geocode_namedplace(places)).*) g
    LOOP
      RETURN NEXT ret;
    END LOOP;
  END IF;
  RETURN;
END
$$;


CREATE OR REPLACE FUNCTION geocode_namedplace(places text[], admin1s text, inputcountry text) RETURNS SETOF geocode_admin1_country_v1
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER
    AS $$
  DECLARE
    ret geocode_admin1_country_v1%rowtype;
    has_country BOOLEAN;
    has_admin1s BOOLEAN;
    admin1s_a TEXT[];
  BEGIN

  has_country := TRUE;
  has_admin1s := TRUE;

  IF inputcountry IS NULL THEN
    has_country := FALSE;
  ELSIF inputcountry = '' THEN
    has_country := FALSE;
  END IF;

  IF admin1s IS NULL THEN
    has_admin1s := FALSE;
  ELSIF admin1s = '' THEN
    has_admin1s := FALSE;
  END IF;

  -- no country value
  IF has_country IS FALSE THEN
    -- no country no admin1 value
    IF has_admin1s IS FALSE THEN
      FOR ret IN SELECT g.q, admin1s AS a1, inputcountry as c, g.geom, g.success FROM (SELECT (geocode_namedplace(places)).*) g LOOP
        RETURN NEXT ret;
      END LOOP;
    -- no country, has admin1 value
    ELSE
      FOR ret IN
          SELECT g.q, admin1s AS a1, inputcountry as c, g.geom, g.success FROM (
          SELECT (
            geocode_namedplace(
              places,
              (SELECT array_agg(a) FROM (SELECT admin1s a FROM GENERATE_SERIES(1, Array_Length(places, 1)) s) r),
              NULL
            )
          ).*) g LOOP
        RETURN NEXT ret;
      END LOOP;
    END IF;
  -- has country value
  ELSE
    -- has country, no admin1 value
    IF has_admin1s IS FALSE THEN
      FOR ret IN SELECT g.q, admin1s AS a1, inputcountry as c, g.geom, g.success FROM (SELECT (geocode_namedplace(places, inputcountry)).*) g LOOP
        RETURN NEXT ret;
      END LOOP;
    -- has country, has admin1 value
    ELSE
      FOR ret IN
          SELECT g.q, admin1s AS a1, inputcountry as c, g.geom, g.success FROM (
          SELECT (
            geocode_namedplace(
              places,
              (SELECT array_agg(a) FROM (SELECT admin1s a FROM GENERATE_SERIES(1, Array_Length(places, 1)) s) r),
              inputcountry
            )
          ).*) g LOOP
        RETURN NEXT ret;
      END LOOP;
    END IF;
  END IF;
  RETURN;
END
$$;


CREATE OR REPLACE FUNCTION geocode_namedplace(places text[], admin1s text[], inputcountry text) RETURNS SETOF geocode_admin1_country_v1
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER
    AS $$
  DECLARE
    ret geocode_admin1_country_v1%rowtype;
    nans TEXT[];
    isoTwo TEXT := NULL;
    has_country BOOLEAN;
  BEGIN
  has_country := TRUE;
  -- find the iso2 code for the input country string, else NULL
  IF inputcountry IS NULL THEN
    has_country := FALSE;
  ELSIF inputcountry = '' THEN
    has_country := FALSE;
  END IF;
  IF has_country THEN
    SELECT iso2 INTO isoTwo FROM country_decoder WHERE lower(geocode_clean_name(inputcountry))::text = ANY (synonyms) LIMIT 1;
  END IF;

  -- find all cases where admin1 is NULL
  SELECT array_agg(p)  INTO nans FROM (SELECT unnest(places) p, unnest(admin1s) c) g WHERE c IS NULL;

  IF 0 < array_length(nans, 1) THEN
    SELECT array_agg(p), array_agg(c) INTO places, admin1s FROM (SELECT unnest(places) p, unnest(admin1s) c) g WHERE c IS NOT NULL;
    IF has_country THEN
      -- geocode our named place without admin1 but with our iso2
      FOR ret IN SELECT g.q, null AS a1, inputcountry as c, g.geom, g.success FROM (SELECT (geocode_namedplace(nans, inputcountry)).*) g LOOP
        RETURN NEXT ret;
      END LOOP;
    ELSE
      -- geocode our named place without admin1 and without iso2
      FOR ret IN SELECT g.q, NULL as a1, inputcountry as c, g.geom, g.success FROM (SELECT (geocode_namedplace(nans)).*) g LOOP
        RETURN NEXT ret;
      END LOOP;
    END IF;
  END IF;

  -- find all cases where admin1 is and empty string
  SELECT array_agg(p)  INTO nans FROM (SELECT unnest(places) p, unnest(admin1s) c) g WHERE c='';

  IF 0 < array_length(nans, 1) THEN
    SELECT array_agg(p), array_agg(c) INTO places, admin1s FROM (SELECT unnest(places) p, unnest(admin1s) c) g WHERE c!='';
    IF has_country THEN
      -- geocode our named place without admin1 but with our iso2
      FOR ret IN
        SELECT g.q, '' AS a1, inputcountry as c, g.geom, g.success FROM (SELECT (geocode_namedplace(nans, inputcountry)).*) g
      LOOP
        RETURN NEXT ret;
      END LOOP;
    ELSE
      -- geocode our named place without admin1 and without iso2
      FOR ret IN
        SELECT g.q, '' AS a1, inputcountry as c, g.geom, g.success FROM (SELECT (geocode_namedplace(nans)).*) g
      LOOP
        RETURN NEXT ret;
      END LOOP;
    END IF;
  END IF;

  -- geocode all the cases where admin1 is available
  IF has_country THEN
    FOR ret IN WITH
      -- return c=iso2 and search without country
      p AS (
        SELECT r.s, r.a1, (SELECT admin1 FROM admin1_decoder WHERE lower(r.a1) = ANY (synonyms) AND admin1_decoder.iso2 = isoTwo LIMIT 1) i FROM (SELECT unnest(places) AS s, unnest(admin1s)::text AS a1) r),
      best AS (SELECT p.s AS q, p.a1 as a1, (SELECT gp.the_geom AS geom FROM global_cities_points_limited gp WHERE gp.lowername = lower(p.s) AND gp.admin1 = p.i ORDER BY population DESC LIMIT 1) AS geom FROM p),
      next AS (SELECT p.s AS q, p.a1 AS a1, (SELECT gp.the_geom FROM global_cities_points_limited gp, global_cities_alternates_limited ga WHERE lower(p.s) = ga.lowername AND ga.admin1 = p.i AND ga.geoname_id = gp.geoname_id ORDER BY preferred DESC LIMIT 1) geom FROM p WHERE p.s NOT IN (SELECT q FROM best WHERE geom IS NOT NULL))
      SELECT q, a1, inputcountry as c, geom, TRUE AS success FROM best WHERE geom IS NOT NULL
      UNION ALL
      SELECT q, a1, inputcountry as c, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success FROM next
      LOOP
      RETURN NEXT ret;
    END LOOP;
  ELSE
    -- return c=NULL and search without country
    FOR ret IN WITH
      p AS (
        SELECT r.s, r.a1, (SELECT admin1 FROM admin1_decoder WHERE lower(r.a1) = ANY (synonyms) LIMIT 1) i FROM (SELECT unnest(places) AS s, unnest(admin1s)::text AS a1) r WHERE a1 IS NOT NULL and a1 != ''),
      best AS (SELECT p.s AS q, p.a1 as a1, (SELECT gp.the_geom AS geom FROM global_cities_points_limited gp WHERE gp.lowername = lower(p.s) AND gp.admin1 = p.i ORDER BY population DESC LIMIT 1) AS geom FROM p),
      next AS (SELECT p.s AS q, p.a1 AS a1, (SELECT gp.the_geom FROM global_cities_points_limited gp, global_cities_alternates_limited ga WHERE lower(p.s) = ga.lowername AND ga.admin1 = p.i AND ga.geoname_id = gp.geoname_id ORDER BY preferred DESC LIMIT 1) geom FROM p WHERE p.s NOT IN (SELECT q FROM best WHERE geom IS NOT NULL))
      SELECT q, a1, inputcountry as c, geom, TRUE AS success FROM best WHERE geom IS NOT NULL
      UNION ALL
      SELECT q, a1, inputcountry as c, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success FROM next
      LOOP
      RETURN NEXT ret;
    END LOOP;
  END IF;
  RETURN;
END
$$;



CREATE OR REPLACE FUNCTION geocode_namedplace(places text[], admin1s text[], inputcountry text[]) RETURNS SETOF geocode_admin1_country_v1
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER
    AS $$
  DECLARE
    ret geocode_admin1_country_v1%rowtype;
  BEGIN
    IF admin1s IS NULL THEN
      FOR ret IN SELECT g.q as q, NULL as a1, g.c as c, g.geom as geom, g.success as success FROM (SELECT (geocode_namedplace(places, inputcountry)).*) g LOOP
          RETURN NEXT ret;
      END LOOP;
    ELSE
      FOR ret IN WITH clean AS (
          SELECT array_agg(p) p, array_agg(a) a, c
          FROM (SELECT p, a, c
                FROM (SELECT p, a, c, nest.ordinality as ord FROM unnest(places, admin1s) with ordinality nest (p, a), LATERAL unnest(inputcountry) with ordinality c) z
                GROUP BY p, a, c, z.ord
                ORDER BY z.ord
              ) y
          GROUP BY c
        )
        SELECT (geocode_namedplace(p, a, c)).* FROM clean
      LOOP
        RETURN NEXT ret;
      END LOOP;
    END IF;
  RETURN;
END
$$;


CREATE OR REPLACE FUNCTION geocode_namedplace(places text[]) RETURNS SETOF geocode_namedplace_v1
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER
    AS $$
  DECLARE
    ret geocode_namedplace_v1%rowtype;
  BEGIN
  FOR ret IN WITH best AS (SELECT s AS q, (SELECT the_geom FROM global_cities_points_limited gp WHERE gp.lowername = lower(p.s) ORDER BY population DESC LIMIT 1) AS geom FROM (SELECT unnest(places) as s) p),
        next AS (SELECT p.s AS q, (SELECT gp.the_geom FROM global_cities_points_limited gp, global_cities_alternates_limited ga WHERE lower(p.s) = ga.lowername AND ga.geoname_id = gp.geoname_id ORDER BY preferred DESC LIMIT 1) geom FROM (SELECT unnest(places) as s) p WHERE p.s NOT IN (SELECT q FROM best WHERE geom IS NOT NULL))
        SELECT q, geom, TRUE AS success FROM best WHERE geom IS NOT NULL
        UNION ALL
        SELECT q, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success FROM next
    LOOP
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$;

CREATE OR REPLACE FUNCTION namedplace_guess_country(places text[])
RETURNS text AS $$
DECLARE
  country_code text;
  threshold CONSTANT float := 0.8;
  input_length integer := array_length(places, 1);
BEGIN
  BEGIN
    WITH hist AS (
        SELECT count(DISTINCT(lower(p.s), gp.iso2)) AS c, iso2
        FROM global_cities_points_limited gp
        inner join (SELECT unnest(places) AS s) p
        ON (gp.lowername = lower(s))
        GROUP BY iso2
      ),
      best_two AS (
        SELECT iso2, c
          FROM hist
          WHERE c > input_length * threshold
          ORDER BY c DESC
          LIMIT 2
      )
    SELECT iso2 INTO STRICT country_code
      FROM (SELECT iso2, c, max(c) over() AS maxcount FROM best_two) bt
      WHERE bt.c = bt.maxcount;
    EXCEPTION
      WHEN NO_DATA_FOUND OR too_many_rows THEN
        RETURN NULL;
  END;
  RETURN country_code;
END;
$$ LANGUAGE 'plpgsql' SECURITY DEFINER IMMUTABLE;


--------------------------------------------------------------------------------

-- Support tables

CREATE TABLE admin1_decoder (
    name text,
    admin1 text,
    iso2 text,
    geoname_id integer,
    cartodb_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom geometry(Geometry,4326),
    the_geom_webmercator geometry(Geometry,3857),
    synonyms text[],
    iso3 text,
    users double precision
);


CREATE SEQUENCE admin1_decoder_cartodb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE admin1_decoder_cartodb_id_seq OWNED BY admin1_decoder.cartodb_id;
ALTER TABLE ONLY admin1_decoder ALTER COLUMN cartodb_id SET DEFAULT nextval('admin1_decoder_cartodb_id_seq'::regclass);


ALTER TABLE ONLY admin1_decoder
    ADD CONSTRAINT admin1_decoder_cartodb_id_key UNIQUE (cartodb_id);
ALTER TABLE ONLY admin1_decoder
    ADD CONSTRAINT admin1_decoder_pkey PRIMARY KEY (cartodb_id);


CREATE INDEX admin1_decoder_the_geom_idx ON admin1_decoder USING gist (the_geom);
CREATE INDEX admin1_decoder_admin1_idx ON admin1_decoder USING btree (admin1);
CREATE INDEX admin1_decoder_geoname_id_idx ON admin1_decoder USING btree (geoname_id);
CREATE INDEX admin1_decoder_iso2_idx ON admin1_decoder USING btree (iso2);
CREATE INDEX admin1_decoder_iso3_idx ON admin1_decoder USING btree (iso3);
CREATE INDEX admin1_decoder_name_idx ON admin1_decoder USING btree (name);


CREATE TRIGGER track_updates AFTER INSERT OR DELETE OR UPDATE OR TRUNCATE ON admin1_decoder FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_tablemetadata_trigger();
CREATE TRIGGER update_the_geom_webmercator_trigger BEFORE INSERT OR UPDATE OF the_geom ON admin1_decoder FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_the_geom_webmercator();
CREATE TRIGGER update_updated_at_trigger BEFORE UPDATE ON admin1_decoder FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_updated_at();


CREATE TABLE global_cities_points_limited (
    geoname_id integer,
    name text,
    asciiname text,
    altnames text,
    featclass text,
    featcode text,
    iso2 text,
    cc2 text,
    admin1 text,
    admin2 text,
    admin3 text,
    admin4 text,
    population double precision,
    gtopo30 integer,
    the_geom geometry(Point,4326),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom_webmercator geometry(Geometry,3857),
    cartodb_id integer NOT NULL,
    lowername text
);


CREATE SEQUENCE points_cities_le_cartodb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE points_cities_le_cartodb_id_seq OWNED BY global_cities_points_limited.cartodb_id;
ALTER TABLE ONLY global_cities_points_limited ALTER COLUMN cartodb_id SET DEFAULT nextval('points_cities_le_cartodb_id_seq'::regclass);

ALTER TABLE ONLY global_cities_points_limited
    ADD CONSTRAINT global_cities_points_limited_cartodb_id_key UNIQUE (cartodb_id);
ALTER TABLE ONLY global_cities_points_limited
    ADD CONSTRAINT global_cities_points_limited_pkey PRIMARY KEY (cartodb_id);


CREATE INDEX global_cities_points_limited_the_geom_idx ON global_cities_points_limited USING gist (the_geom);
CREATE INDEX global_cities_points_limited_the_geom_webmercator_idx ON global_cities_points_limited USING gist (the_geom_webmercator);
CREATE INDEX global_cities_points_limited_lower_iso2_idx ON global_cities_points_limited USING btree (lowername, iso2);
CREATE INDEX global_cities_points_limited_admin1_idx ON global_cities_points_limited USING btree (admin1);
CREATE INDEX global_cities_points_limited_geoname_id_idx ON global_cities_points_limited USING btree (geoname_id);


CREATE TRIGGER track_updates AFTER INSERT OR DELETE OR UPDATE OR TRUNCATE ON global_cities_points_limited FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_tablemetadata_trigger();
CREATE TRIGGER update_the_geom_webmercator_trigger BEFORE INSERT OR UPDATE OF the_geom ON global_cities_points_limited FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_the_geom_webmercator();
CREATE TRIGGER update_updated_at_trigger BEFORE UPDATE ON global_cities_points_limited FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_updated_at();


CREATE TABLE global_cities_alternates_limited (
    geoname_id integer,
    name text,
    the_geom geometry(Geometry,4326),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom_webmercator geometry(Geometry,3857),
    preferred boolean,
    lowername text,
    cartodb_id integer NOT NULL,
    admin1_geonameid integer,
    iso2 text,
    admin1 text
);


CREATE SEQUENCE global_cities_alternates_limited_cartodb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE global_cities_alternates_limited_cartodb_id_seq OWNED BY global_cities_alternates_limited.cartodb_id;
ALTER TABLE ONLY global_cities_alternates_limited ALTER COLUMN cartodb_id SET DEFAULT nextval('global_cities_alternates_limited_cartodb_id_seq'::regclass);

ALTER TABLE ONLY global_cities_alternates_limited
    ADD CONSTRAINT points_cities_alternates_limited_cartodb_id_key UNIQUE (cartodb_id);
ALTER TABLE ONLY global_cities_alternates_limited
    ADD CONSTRAINT global_cities_alternates_limited_pkey PRIMARY KEY (cartodb_id);


CREATE INDEX global_cities_alternates_limited_the_geom_idx ON global_cities_alternates_limited USING gist (the_geom);
CREATE INDEX global_cities_alternates_limited_the_geom_webmercator_idx ON global_cities_alternates_limited USING gist (the_geom_webmercator);
CREATE INDEX global_cities_alternates_limited_admin1_idx ON global_cities_alternates_limited USING btree (admin1);
CREATE INDEX global_cities_alternates_limited_admin1_geonameid_idx ON global_cities_alternates_limited USING btree (admin1_geonameid);
CREATE INDEX global_cities_alternates_limited_lowername_idx ON global_cities_alternates_limited USING btree (lowername);


CREATE TRIGGER track_updates AFTER INSERT OR DELETE OR UPDATE OR TRUNCATE ON global_cities_alternates_limited FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_tablemetadata_trigger();
CREATE TRIGGER update_the_geom_webmercator_trigger BEFORE INSERT OR UPDATE OF the_geom ON global_cities_alternates_limited FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_the_geom_webmercator();
CREATE TRIGGER update_updated_at_trigger BEFORE UPDATE ON global_cities_alternates_limited FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_updated_at();

-- Complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION cdb_geocoder" to load this file. \quit
-- Cleaning function
CREATE OR REPLACE FUNCTION geocode_clean_name(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
  BEGIN
    RETURN regexp_replace(name, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g');
  END
$$;
-- Public API functions --
--- Geocoding function ---
-- TODO: deal with permissions

CREATE OR REPLACE FUNCTION geocode_ip(ip text[]) RETURNS SETOF geocode_ip_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
  DECLARE 
    ret geocode_ip_v1%rowtype;
    n TEXT;
    new_ips INET[];
    old_ips TEXT[];
  BEGIN
  FOR n IN SELECT unnest(ip) LOOP
    BEGIN
      IF family(n::inet)=6 THEN
        new_ips := array_append(new_ips, n::inet);
        old_ips := array_append(old_ips, n);
      ELSE
        new_ips := array_append(new_ips, ('::ffff:'||n)::inet);
        old_ips := array_append(old_ips, n);
      END IF;
    EXCEPTION WHEN OTHERS THEN
      SELECT n AS q, NULL as geom, FALSE as success INTO ret;
      RETURN NEXT ret;
    END;
  END LOOP;
  FOR ret IN WITH ips AS (SELECT unnest(old_ips) s, unnest(new_ips) net),
    matches AS (SELECT s, (SELECT the_geom FROM ip_address_locations WHERE network_start_ip <= ips.net ORDER BY network_start_ip DESC LIMIT 1) geom FROM ips)
    SELECT s, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success FROM matches
    LOOP
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$;

--------------------------------------------------------------------------------

-- Support tables

CREATE TABLE ip_address_locations (
    network_start_ip inet,
    the_geom geometry(Geometry,4326),
    cartodb_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom_webmercator geometry(Geometry,3857)
);

CREATE SEQUENCE geolite2_city_blocks_cartodb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE geolite2_city_blocks_cartodb_id_seq OWNED BY ip_address_locations.cartodb_id;
ALTER TABLE ONLY ip_address_locations ALTER COLUMN cartodb_id SET DEFAULT nextval('geolite2_city_blocks_cartodb_id_seq'::regclass);


ALTER TABLE ONLY ip_address_locations
    ADD CONSTRAINT ip_address_locations_cartodb_id_key UNIQUE (cartodb_id);
ALTER TABLE ONLY ip_address_locations
    ADD CONSTRAINT ip_address_locations_pkey PRIMARY KEY (cartodb_id);


CREATE INDEX ip_address_locations_the_geom_idx ON ip_address_locations USING gist (the_geom);
CREATE INDEX ip_address_locations_the_geom_webmercator_idx ON ip_address_locations USING gist (the_geom_webmercator);
CREATE INDEX ip_address_locations_startip_idx ON ip_address_locations USING btree (network_start_ip);

CREATE TRIGGER track_updates AFTER INSERT OR DELETE OR UPDATE OR TRUNCATE ON ip_address_locations FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_tablemetadata_trigger();
CREATE TRIGGER update_the_geom_webmercator_trigger BEFORE INSERT OR UPDATE OF the_geom ON ip_address_locations FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_the_geom_webmercator();
CREATE TRIGGER update_updated_at_trigger BEFORE UPDATE ON ip_address_locations FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_updated_at();

-- Public API functions --
--- Geocoding function ---
-- TODO: deal with permissions

CREATE FUNCTION geocode_postalcode_polygons(code text[], inputcountries text[]) RETURNS SETOF geocode_namedplace_country_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
  DECLARE
    ret geocode_namedplace_country_v1%rowtype;
    adm text[];
  BEGIN

  SELECT INTO adm array_agg((SELECT adm0_a3 FROM admin0_synonyms WHERE name_ = lower(geocode_clean_name(b.c))::text LIMIT 1)) FROM (SELECT UNNEST(inputcountries) c) b;

  FOR ret IN
    SELECT
      q, c, geom, CASE WHEN geom IS NULL THEN FALSE ELSE TRUE END AS success
    FROM (
      SELECT
        q, c, (
          SELECT the_geom
          FROM global_postal_code_polygons
          WHERE postal_code = CASE WHEN a = 'CAN' THEN substring(upper(d.q) from 1 for 3) ELSE upper(d.q) END
            AND iso3 = a
        ) geom
      FROM (SELECT unnest(code) q, unnest(inputcountries) c, unnest(adm) a) d
    ) v
  LOOP
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$;


-- TODO: The next function works with an incorrect table

CREATE FUNCTION geocode_postalcode_polygons(code text[], inputcountry text) RETURNS SETOF geocode_namedplace_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
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
                lower(geocode_clean_name(inputcountry))::text = ANY (synonyms) LIMIT 1
            )
        ) geom
      FROM (SELECT unnest(code) q) d
    ) v
  LOOP
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$;

-- TODO: The next function works with an incorrect table

CREATE FUNCTION geocode_postalcode_polygons(code text[]) RETURNS SETOF geocode_namedplace_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
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
          LIMIT 1
        ) geom
      FROM (SELECT unnest(code) q) d
    ) v
  LOOP
    RETURN NEXT ret;
  END LOOP;
  RETURN;
END
$$;

------ POINTS ------


CREATE FUNCTION geocode_postalcode_points(code text[], inputcountry text) RETURNS SETOF geocode_namedplace_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
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
                lower(geocode_clean_name(inputcountry))::text = ANY (synonyms) LIMIT 1
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
$$;



CREATE FUNCTION geocode_postalcode_points(code integer[], inputcountries text[]) RETURNS SETOF geocode_postalint_country_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
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
                lower(geocode_clean_name(d.c))::text = ANY (synonyms) LIMIT 1
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
$$;



CREATE FUNCTION geocode_postalcode_points(code text[]) RETURNS SETOF geocode_namedplace_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
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
$$;



CREATE FUNCTION geocode_postalcode_points(code text[], inputcountries text[]) RETURNS SETOF geocode_place_country_iso_v1
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
                lower(geocode_clean_name(d.c))::text = ANY (synonyms) LIMIT 1) iso3, (
          SELECT the_geom
          FROM global_postal_code_points
          WHERE postal_code = upper(d.q)
            AND iso3 = (
                SELECT iso3 FROM country_decoder WHERE
                lower(geocode_clean_name(d.c))::text = ANY (synonyms) LIMIT 1
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



CREATE FUNCTION geocode_greatbritain_outward(code text) RETURNS geometry
    LANGUAGE plpgsql
    AS $$
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
$$;


CREATE FUNCTION admin0_available_services(name text[]) RETURNS SETOF available_services_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
  DECLARE
    ret available_services_v1%rowtype;
  BEGIN  RETURN QUERY
    SELECT d.q, n.adm0_a3, n.postal_code_points, n.postal_code_polygons FROM
      (
        SELECT q, lower(geocode_clean_name(q))::text x FROM
          (
            SELECT unnest(name) q
          )
      g) d LEFT OUTER JOIN admin0_synonyms s ON name_ = d.x LEFT OUTER JOIN available_services n ON s.adm0_a3 = n.adm0_a3 GROUP BY d.q, n.adm0_a3, n.postal_code_points, n.postal_code_polygons;
END
$$;
--------------------------------------------------------------------------------

-- Support tables

CREATE TABLE global_postal_code_polygons (
    the_geom geometry(Geometry,4326),
    zcta5ce10 text,
    geoid10 text,
    mtfcc10 text,
    cartodb_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom_webmercator geometry(Geometry,3857),
    iso3 text,
    postal_code text,
    postal_code_num integer
);


CREATE SEQUENCE tl_2013_us_zcta510_cartodb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE tl_2013_us_zcta510_cartodb_id_seq OWNED BY global_postal_code_polygons.cartodb_id;
ALTER TABLE ONLY global_postal_code_polygons ALTER COLUMN cartodb_id SET DEFAULT nextval('tl_2013_us_zcta510_cartodb_id_seq'::regclass);


ALTER TABLE ONLY global_postal_code_polygons
    ADD CONSTRAINT global_postal_code_polygons_cartodb_id_key UNIQUE (cartodb_id);
ALTER TABLE ONLY global_postal_code_polygons
    ADD CONSTRAINT global_postal_code_polygons_pkey PRIMARY KEY (cartodb_id);


CREATE INDEX global_postal_code_polygons_the_geom_idx ON global_postal_code_polygons USING gist (the_geom);
CREATE INDEX global_postal_code_polygons_the_geom_webmercator_idx ON global_postal_code_polygons USING gist (the_geom_webmercator);
CREATE INDEX global_postal_code_polygons_postal_code_idx ON global_postal_code_polygons USING btree (postal_code);
CREATE INDEX global_postal_code_polygons_iso3_idx ON global_postal_code_polygons USING btree (iso3);
CREATE INDEX global_global_postal_code_polygons_postal_code_num_idx ON global_postal_code_polygons USING btree (postal_code_num);


CREATE TRIGGER track_updates AFTER INSERT OR DELETE OR UPDATE OR TRUNCATE ON global_postal_code_polygons FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_tablemetadata_trigger();
CREATE TRIGGER update_the_geom_webmercator_trigger BEFORE INSERT OR UPDATE OF the_geom ON global_postal_code_polygons FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_the_geom_webmercator();
CREATE TRIGGER update_updated_at_trigger BEFORE UPDATE ON global_postal_code_polygons FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_updated_at();


CREATE TABLE global_postal_code_points (
    iso2 text,
    postal_code text,
    place_name text,
    admin_name1 text,
    admin_code1 text,
    admin_name2 text,
    admin_code2 text,
    admin_name3 text,
    admin_code3 text,
    accuracy text,
    the_geom geometry(Geometry,4326),
    cartodb_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom_webmercator geometry(Geometry,3857),
    iso3 text,
    frompoly boolean,
    postal_code_num integer,
    datasource text
);


CREATE SEQUENCE allcountries_cartodb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE allcountries_cartodb_id_seq OWNED BY global_postal_code_points.cartodb_id;
ALTER TABLE ONLY global_postal_code_points ALTER COLUMN cartodb_id SET DEFAULT nextval('allcountries_cartodb_id_seq'::regclass);


ALTER TABLE ONLY global_postal_code_points
    ADD CONSTRAINT global_postal_code_points_cartodb_id_key UNIQUE (cartodb_id);
ALTER TABLE ONLY global_postal_code_points
    ADD CONSTRAINT global_postal_code_points_pkey PRIMARY KEY (cartodb_id);


CREATE INDEX global_postal_code_points_the_geom_idx ON global_postal_code_points USING gist (the_geom);
CREATE INDEX global_postal_code_points_the_geom_webmercator_idx ON global_postal_code_points USING gist (the_geom_webmercator);
CREATE INDEX global_postal_code_points_postal_code_idx ON global_postal_code_points USING btree (postal_code);
CREATE INDEX global_postal_code_points_iso3_idx ON global_postal_code_points USING btree (iso3);
CREATE INDEX global_postal_code_points_postal_code_num_idx ON global_postal_code_points USING btree (postal_code_num);


CREATE TRIGGER track_updates AFTER INSERT OR DELETE OR UPDATE OR TRUNCATE ON global_postal_code_points FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_tablemetadata_trigger();
CREATE TRIGGER update_the_geom_webmercator_trigger BEFORE INSERT OR UPDATE OF the_geom ON global_postal_code_points FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_the_geom_webmercator();
CREATE TRIGGER update_updated_at_trigger BEFORE UPDATE ON global_postal_code_points FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_updated_at();



CREATE TABLE available_services (
    adm0_a3 text,
    admin0 boolean,
    cartodb_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom geometry(Geometry,4326),
    the_geom_webmercator geometry(Geometry,3857),
    postal_code_points boolean,
    postal_code_polygons boolean
);

CREATE SEQUENCE available_services_cartodb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE available_services_cartodb_id_seq OWNED BY available_services.cartodb_id;
ALTER TABLE ONLY available_services ALTER COLUMN cartodb_id SET DEFAULT nextval('available_services_cartodb_id_seq'::regclass);


ALTER TABLE ONLY available_services
    ADD CONSTRAINT available_services_cartodb_id_key UNIQUE (cartodb_id);
ALTER TABLE ONLY available_services
    ADD CONSTRAINT available_services_pkey PRIMARY KEY (cartodb_id);



CREATE INDEX available_services_the_geom_idx ON available_services USING gist (the_geom);
CREATE INDEX available_services_the_geom_webmercator_idx ON available_services USING gist (the_geom_webmercator);


CREATE TRIGGER track_updates AFTER INSERT OR DELETE OR UPDATE OR TRUNCATE ON available_services FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_tablemetadata_trigger();
CREATE TRIGGER update_the_geom_webmercator_trigger BEFORE INSERT OR UPDATE OF the_geom ON available_services FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_the_geom_webmercator();
CREATE TRIGGER update_updated_at_trigger BEFORE UPDATE ON available_services FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_updated_at();
-- Public API functions --
--- Geocoding function ---
-- TODO: deal with permissions
CREATE OR REPLACE FUNCTION geocode_admin0_polygons(name text[])
  RETURNS SETOF geocode_admin_v1 AS $$
  DECLARE
    ret geocode_admin_v1%rowtype;
  BEGIN
  -- FOR ret IN
  RETURN QUERY
    SELECT q, n.the_geom as geom, CASE WHEN s.adm0_a3 IS NULL then FALSE ELSE TRUE END AS success
    FROM unnest(name) WITH ORDINALITY q
    LEFT OUTER JOIN admin0_synonyms s ON name_ = lower(geocode_clean_name(q))::text
    LEFT OUTER JOIN ne_admin0_v3 n ON s.adm0_a3 = n.adm0_a3
    GROUP BY q, n.the_geom, s.adm0_a3, q.ordinality
    ORDER BY q.ordinality;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;


-- admin0_synonym_lookup
CREATE OR REPLACE FUNCTION admin0_synonym_lookup(name text[])
 RETURNS SETOF synonym_lookup_v1 AS $$
 DECLARE
    ret synonym_lookup_v1%rowtype;
 BEGIN  RETURN QUERY
    SELECT q, s.adm0_a3
    FROM unnest(name) WITH ORDINALITY q
    LEFT OUTER JOIN admin0_synonyms s ON name_ = lower(geocode_clean_name(q))::text
    GROUP BY q, s.adm0_a3, q.ordinality
    ORDER BY q.ordinality;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;

--------------------------------------------------------------------------------

-- Support tables

CREATE TABLE admin0_synonyms (
    name text,
    rank double precision,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom geometry(Geometry,4326),
    the_geom_webmercator geometry(Geometry,3857),
    cartodb_id integer NOT NULL,
    adm0_a3 text,
    name_ text
);

CREATE SEQUENCE admin0_synonyms_cartodb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE admin0_synonyms_cartodb_id_seq OWNED BY admin0_synonyms.cartodb_id;
ALTER TABLE ONLY admin0_synonyms ALTER COLUMN cartodb_id SET DEFAULT nextval('admin0_synonyms_cartodb_id_seq'::regclass);


ALTER TABLE ONLY admin0_synonyms
    ADD CONSTRAINT admin0_synonyms_cartodb_id_key UNIQUE (cartodb_id);
ALTER TABLE ONLY admin0_synonyms
    ADD CONSTRAINT admin0_synonyms_pkey PRIMARY KEY (cartodb_id);


CREATE INDEX admin0_synonyms_the_geom_idx ON admin0_synonyms USING gist (the_geom);
CREATE INDEX admin0_synonyms_the_geom_webmercator_idx ON admin0_synonyms USING gist (the_geom_webmercator);
CREATE INDEX idx_admin0_synonyms_nam ON admin0_synonyms USING btree (name);
CREATE INDEX idx_admin0_synonyms_name ON admin0_synonyms USING btree (lower(regexp_replace(name, '\W+'::text, ''::text)));
CREATE INDEX idx_admin0_synonyms_name_ ON admin0_synonyms USING btree (name_);
CREATE INDEX idx_admin0_synonyms_name_patt ON admin0_synonyms USING btree (name_ text_pattern_ops);
CREATE INDEX idx_admin0_synonyms_name_rank ON admin0_synonyms USING btree (name_, rank);
CREATE INDEX idx_admin0_synonyms_rank ON admin0_synonyms USING btree (rank);

-- create trigger function. used in both admin0 and admin1 synonym tables
CREATE OR REPLACE FUNCTION alpha_numeric_identifiers() RETURNS trigger AS $alpha_numeric_identifiers$
    BEGIN
        NEW.name_ := lower(geocode_clean_name(NEW.name));
        RETURN NEW;
    END;
$alpha_numeric_identifiers$ LANGUAGE plpgsql;

CREATE TRIGGER admin0_synonyms_name_update BEFORE INSERT OR UPDATE OF name ON admin0_synonyms FOR EACH ROW EXECUTE PROCEDURE alpha_numeric_identifiers();
CREATE TRIGGER track_updates AFTER INSERT OR DELETE OR UPDATE OR TRUNCATE ON admin0_synonyms FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_tablemetadata_trigger();
CREATE TRIGGER update_the_geom_webmercator_trigger BEFORE INSERT OR UPDATE OF the_geom ON admin0_synonyms FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_the_geom_webmercator();
CREATE TRIGGER update_updated_at_trigger BEFORE UPDATE ON admin0_synonyms FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_updated_at();




CREATE TABLE ne_admin0_v3 (
    the_geom geometry(Geometry,4326),
    scalerank integer,
    featurecla text,
    labelrank double precision,
    sovereignt text,
    sov_a3 text,
    adm0_dif double precision,
    level double precision,
    type text,
    admin text,
    adm0_a3 text,
    geou_dif double precision,
    geounit text,
    gu_a3 text,
    su_dif double precision,
    subunit text,
    su_a3 text,
    brk_diff double precision,
    name text,
    name_long text,
    brk_a3 text,
    brk_name text,
    brk_group text,
    abbrev text,
    postal text,
    formal_en text,
    formal_fr text,
    note_adm0 text,
    note_brk text,
    name_sort text,
    name_alt text,
    mapcolor7 double precision,
    mapcolor8 double precision,
    mapcolor9 double precision,
    mapcolor13 double precision,
    pop_est double precision,
    gdp_md_est double precision,
    pop_year double precision,
    lastcensus double precision,
    gdp_year double precision,
    economy text,
    income_grp text,
    wikipedia double precision,
    fips_10_ text,
    iso_a2 text,
    iso_a3 text,
    iso_n3 text,
    un_a3 text,
    wb_a2 text,
    wb_a3 text,
    woe_id double precision,
    woe_id_eh double precision,
    woe_note text,
    adm0_a3_is text,
    adm0_a3_us text,
    adm0_a3_un double precision,
    adm0_a3_wb double precision,
    continent text,
    region_un text,
    subregion text,
    region_wb text,
    name_len double precision,
    long_len double precision,
    abbrev_len double precision,
    tiny double precision,
    homepart double precision,
    cartodb_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom_webmercator geometry(Geometry,3857)
)
WITH (autovacuum_enabled=true, toast.autovacuum_enabled=true);

CREATE SEQUENCE ne_10m_admin_0_countries_1_cartodb_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE ne_10m_admin_0_countries_1_cartodb_id_seq1 OWNED BY ne_admin0_v3.cartodb_id;
ALTER TABLE ONLY ne_admin0_v3 ALTER COLUMN cartodb_id SET DEFAULT nextval('ne_10m_admin_0_countries_1_cartodb_id_seq1'::regclass);
ALTER TABLE ONLY ne_admin0_v3
    ADD CONSTRAINT ne_10m_admin_0_countries_1_cartodb_id_key UNIQUE (cartodb_id);
ALTER TABLE ONLY ne_admin0_v3
    ADD CONSTRAINT ne_10m_admin_0_countries_1_pkey1 PRIMARY KEY (cartodb_id);

CREATE INDEX idx_ne_admin0_v3_a3 ON ne_admin0_v3 USING btree (adm0_a3);
CREATE UNIQUE INDEX idx_ne_admin0_v3_adm0_a3 ON ne_admin0_v3 USING btree (adm0_a3);
CREATE INDEX ne_10m_admin_0_countries_1_the_geom_webmercator_idx ON ne_admin0_v3 USING gist (the_geom_webmercator);
CREATE INDEX the_geom_4e1a2710_110a_11e4_b0ba_7054d21a95e5 ON ne_admin0_v3 USING gist (the_geom);

CREATE TRIGGER test_quota BEFORE INSERT OR UPDATE ON ne_admin0_v3 FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_checkquota('1', '-1', 'public');
CREATE TRIGGER test_quota_per_row BEFORE INSERT OR UPDATE ON ne_admin0_v3 FOR EACH ROW EXECUTE PROCEDURE cartodb.cdb_checkquota('0.001', '-1', 'public');
CREATE TRIGGER track_updates AFTER INSERT OR DELETE OR UPDATE OR TRUNCATE ON ne_admin0_v3 FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_tablemetadata_trigger();
CREATE TRIGGER update_the_geom_webmercator_trigger BEFORE INSERT OR UPDATE OF the_geom ON ne_admin0_v3 FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_the_geom_webmercator();
CREATE TRIGGER update_updated_at_trigger BEFORE UPDATE ON ne_admin0_v3 FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_updated_at();
CREATE TABLE country_decoder (
    name text,
    nativename text,
    tld text,
    iso2 text,
    ccn3 text,
    iso3 text,
    currency text,
    callingcode text,
    capital text,
    altspellings text,
    relevance text,
    region text,
    subregion text,
    language text,
    languagescodes text,
    translations text,
    population text,
    latlng text,
    demonym text,
    borders text,
    the_geom geometry(Geometry,4326),
    cartodb_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom_webmercator geometry(Geometry,3857),
    synbu text[],
    synonyms text[],
    users double precision
);


CREATE SEQUENCE countries_cartodb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE countries_cartodb_id_seq OWNED BY country_decoder.cartodb_id;
ALTER TABLE ONLY country_decoder ALTER COLUMN cartodb_id SET DEFAULT nextval('countries_cartodb_id_seq'::regclass);

ALTER TABLE ONLY country_decoder
    ADD CONSTRAINT country_decoder_cartodb_id_key UNIQUE (cartodb_id);
ALTER TABLE ONLY country_decoder
    ADD CONSTRAINT country_decoder_pkey PRIMARY KEY (cartodb_id);
ALTER TABLE country_decoder CLUSTER ON country_decoder_pkey;


CREATE INDEX country_decoder_the_geom_idx ON country_decoder USING gist (the_geom);
CREATE INDEX country_decoder_the_geom_webmercator_idx ON country_decoder USING gist (the_geom_webmercator);

CREATE TRIGGER track_updates AFTER INSERT OR DELETE OR UPDATE OR TRUNCATE ON country_decoder FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_tablemetadata_trigger();
CREATE TRIGGER update_the_geom_webmercator_trigger BEFORE INSERT OR UPDATE OF the_geom ON country_decoder FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_the_geom_webmercator();
CREATE TRIGGER update_updated_at_trigger BEFORE UPDATE ON country_decoder FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_updated_at();
