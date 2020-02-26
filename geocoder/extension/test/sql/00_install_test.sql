-- Install dependencies
CREATE EXTENSION postgis;
CREATE EXTENSION @@plpythonu@@;
CREATE EXTENSION cartodb;

-- Mock the quota check
SELECT cartodb.CDB_SetUserQuotaInBytes(0);

-- Install the extension
CREATE EXTENSION cdb_geocoder;

-- Mock the varnish invalidation function
CREATE OR REPLACE FUNCTION public.cdb_invalidate_varnish(table_name text) RETURNS void AS $$
BEGIN
  RETURN;
END
$$
LANGUAGE plpgsql;
