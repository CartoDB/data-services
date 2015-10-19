-- Index on IP addresses table
CREATE UNIQUE INDEX idx_ip_address_locations_start ON ip_address_locations (network_start_ip)
