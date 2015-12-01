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
      FOR ret IN WITH clean AS (SELECT array_agg(p) p, array_agg(a) a, c FROM (SELECT p, a, c FROM (SELECT unnest(places) p, unnest(admin1s) a, unnest(inputcountry) c) z GROUP BY p, a, c) y GROUP BY c)
        SELECT (geocode_namedplace(p, a, c)).* FROM clean LOOP
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

