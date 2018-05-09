
---- IP addresses table ---

-- Clear table
DELETE FROM ip_address_locations;
-- Updates table with new source data
INSERT INTO ip_address_locations (the_geom, network_start_ip) SELECT the_geom, ('::ffff:' || split_part(network, '/', 1))::inet FROM latest_ip_address_locations;
DROP TABLE latest_ip_address_locations;

-- Update table

-- Assumptions (read https://github.com/CartoDB/data-services/tree/master/geocoder/ip-addresses#creation-steps)
-- - latest_ip_address_locations is the GeoLite2-City-Blocks-IPv4.csv table
-- - latest_ip6_address_locations is the GeoLite2-City-Blocks-IPv6.csv table
-- - For option B (exported file), export from valid `ip_address_locations` table with
--      \copy (select * from ip_address_locations) TO /tmp/ip_address_locations.dump;

CREATE TABLE ip_address_locations_backup as select * from ip_address_locations;
TRUNCATE ip_address_locations;

-- OPTION A) From scratch
INSERT INTO ip_address_locations (the_geom, network_start_ip) SELECT the_geom, ('::ffff:' || split_part(network, '/', 1))::inet FROM latest_ip_address_locations;
INSERT INTO ip_address_locations (the_geom, network_start_ip) SELECT the_geom, split_part(network, '/', 1)::inet FROM latest_ip6_address_locations;

-- OPTION B) From exported file (took 9 minutes in staging)
\copy ip_address_locations from /tmp/ip_address_locations.dump