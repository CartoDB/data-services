--
-- Name: test_geocode_admin0_polygons(text[]); Type: FUNCTION; Schema: public; Owner: cartodb_user_256c8c82-e93c-486d-b17d-c9d6b40009a0
--

CREATE FUNCTION test_geocode_admin0_polygons(name text[]) RETURNS SETOF geocode_admin_v1
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
  DECLARE 
    ret geocode_admin_v1%rowtype;
  BEGIN  RETURN QUERY
    SELECT d.q, n.the_geom as geom, CASE WHEN s.adm0_a3 IS NULL then FALSE ELSE TRUE END AS success FROM (SELECT q, lower(regexp_replace(q, '[^A-z\u00C0-\u00ff]+', '', 'g'))::text x FROM (SELECT unnest(name) q) g) d LEFT OUTER JOIN admin0_synonyms s ON name_ = d.x LEFT OUTER JOIN ne_admin0_v3 n ON s.adm0_a3 = n.adm0_a3;
END
$$;
