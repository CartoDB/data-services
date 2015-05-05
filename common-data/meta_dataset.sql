--
-- Name: meta_dataset; Type: TABLE; Schema: public
--

CREATE TABLE meta_dataset (
    cartodb_id integer NOT NULL,
    name text,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom geometry(Geometry,4326),
    the_geom_webmercator geometry(Geometry,3857),
    source text,
    license text,
    meta_category_id integer,
    tabname text,
    geometry_types text
);

ALTER TABLE ONLY meta_dataset
    ADD CONSTRAINT meta_dataset_meta_category_id_fkey FOREIGN KEY (meta_category_id) REFERENCES meta_category(cartodb_id);
