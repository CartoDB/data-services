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
