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

