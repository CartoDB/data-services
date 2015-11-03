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


CREATE SEQUENCE country_decoder_cartodb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE country_decoder_cartodb_id_seq OWNED BY country_decoder.cartodb_id;
ALTER TABLE ONLY country_decoder ALTER COLUMN cartodb_id SET DEFAULT nextval('country_decoder_cartodb_id_seq'::regclass);

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
