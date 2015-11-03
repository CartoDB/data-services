-- Response types for admin0 geocoder
CREATE TYPE geocode_admin_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE synonym_lookup_v1 AS (q TEXT, adm0_a3 TEXT);

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
    SELECT d.q, n.the_geom as geom, CASE WHEN s.adm0_a3 IS NULL then FALSE ELSE TRUE END AS success
      FROM (SELECT q, lower(regexp_replace(q, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text x
        FROM (SELECT unnest(name) q) g) d
      LEFT OUTER JOIN admin0_synonyms s ON name_ = d.x
      LEFT OUTER JOIN ne_admin0_v3 n ON s.adm0_a3 = n.adm0_a3 GROUP BY d.q, n.the_geom, s.adm0_a3;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;


-- admin0_synonym_lookup
CREATE OR REPLACE FUNCTION admin0_synonym_lookup(name text[])
 RETURNS SETOF synonym_lookup_v1 AS $$
 DECLARE
    ret synonym_lookup_v1%rowtype;
 BEGIN  RETURN QUERY
    SELECT d.q, s.adm0_a3
      FROM (SELECT q, lower(regexp_replace(q, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text x
        FROM (SELECT unnest(name) q) g) d
      LEFT OUTER JOIN admin0_synonyms s ON name_ = d.x GROUP BY d.q, s.adm0_a3;
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
        NEW.name_ := lower(regexp_replace(NEW.name, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'));
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
