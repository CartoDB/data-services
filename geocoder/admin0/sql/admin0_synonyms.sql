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



CREATE TRIGGER admin0_synonyms_name_update BEFORE INSERT OR UPDATE OF name ON admin0_synonyms FOR EACH ROW EXECUTE PROCEDURE alpha_numeric_identifiers();



CREATE TRIGGER track_updates AFTER INSERT OR DELETE OR UPDATE OR TRUNCATE ON admin0_synonyms FOR EACH STATEMENT EXECUTE PROCEDURE cartodb.cdb_tablemetadata_trigger();



CREATE TRIGGER update_the_geom_webmercator_trigger BEFORE INSERT OR UPDATE OF the_geom ON admin0_synonyms FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_the_geom_webmercator();


CREATE TRIGGER update_updated_at_trigger BEFORE UPDATE ON admin0_synonyms FOR EACH ROW EXECUTE PROCEDURE cartodb._cdb_update_updated_at();

