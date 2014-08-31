
---- IP addresses table ---
--- ---

-- Clear table

DELETE FROM ip_address_locations;
INSERT INTO ip_address_locations (the_geom, network_start_ip) SELECT the_geom, network_start_ip::inet FROM latest_ip_address_locations;
DROP TABLE latest_ip_address_locations;
