--- Usage

-- SELECT geocode_ip(Array['1.0.16.0', '::ffff:1.0.16.0'])


--- Function


CREATE OR REPLACE FUNCTION geocode_ip(ip text[])
  RETURNS SETOF geocode_ip_v1 AS $$
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
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;
