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

  SELECT INTO adm array_agg((SELECT adm0_a3 FROM admin0_synonyms WHERE name_ = lower(regexp_replace(b.c, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text LIMIT 1)) FROM (SELECT UNNEST(inputcountries) c) b;

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
                lower(regexp_replace(inputcountry, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text = ANY (synonyms) LIMIT 1
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
                lower(regexp_replace(inputcountry, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text = ANY (synonyms) LIMIT 1
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
                lower(regexp_replace(d.c, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text = ANY (synonyms) LIMIT 1
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
  DECLARElower(regexp_replace(inputcountry, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text
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
                lower(d.c) = ANY (synonyms) LIMIT 1) iso3, (
          SELECT the_geom
          FROM global_postal_code_points
          WHERE postal_code = upper(d.q)
            AND iso3 = (
                SELECT iso3 FROM country_decoder WHERE
                lower(regexp_replace(d.c, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text = ANY (synonyms) LIMIT 1
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
        SELECT q, lower(regexp_replace(q, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text x FROM
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
