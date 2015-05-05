--
-- Name: meta_category; Type: TABLE; Schema: public
--

CREATE TABLE meta_category (
    cartodb_id integer NOT NULL,
    name text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    the_geom geometry(Geometry,4326),
    the_geom_webmercator geometry(Geometry,3857),
    image_url text
);
