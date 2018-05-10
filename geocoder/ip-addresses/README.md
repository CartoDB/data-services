IP address geocoder
===============

# Function

Receives an array of IP addresses (both IPv4 and IPv6) and returns a point geometry for each input if the geocoding process is successful.

# Usage example
```sql
SELECT geocode_ip(Array['1.0.16.0', '::ffff:1.0.16.0'])
```

# Creation steps
1. Create the `ip_address_locations` table (see `40_ipaddr.sql` file)
2. Obtain the file from http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip
3. Uncompress it and upload the `GeoLite2-City-Blocks-IPv4.csv` file
4. Rename the uploaded table as `latest_ip_address_locations`
5. Run the `sql/build_data_table` script to update the table

# Update steps

## Option A: generate a new `ip_address_locations` table at geocoder user

If the geocoder database is a CARTO user, do these steps:

1. Import `GeoLite2-City-Blocks-IPv4.csv` and rename it to `latest_ip_address_locations`.
2. Import `GeoLite2-City-Blocks-IPv6.csv` and rename it to `latest_ip6_address_locations`.
3. If you want to create a backup of the previous table, do this:

    ```sql
    CREATE TABLE ip_address_locations_backup as
        select * from ip_address_locations;
    ```

4. Clear previous table:

    ```sql
    TRUNCATE ip_address_locations;
    ```

5. Load the new values:

```sql
set statement_timeout = '20min';
INSERT INTO ip_address_locations (the_geom, network_start_ip) SELECT the_geom, ('::ffff:' || split_part(network, '/', 1))::inet FROM latest_ip_address_locations;
INSERT INTO ip_address_locations (the_geom, network_start_ip) SELECT the_geom, split_part(network, '/', 1)::inet FROM latest_ip6_address_locations;
```

## Option B: load a dump of the table

If the geocoder database is not a CARTO user, do these steps:

1. Perform option A in any user (it can even be a staging user). If you need to create the table, check `40_ipaddr.sql`.
2. Generate a dump of the file at that user database:

    ```sql
    \copy (select * from ip_address_locations) TO /tmp/ip_address_locations.dump;
    ```

3. Copy the file to the remote server.
4. Perform steps A.3 and A.4.
5. Load the new data (takes ~10 minutes):

```sql
set statement_timeout = '20min';
\copy ip_address_locations from /tmp/ip_address_locations.dump
```

# Tables

### ip_address_locations
This table, obtained from GeoLite and curated with `sql/build_data_table` contains a list of IP addresses and their location.

#### Table structure

````

                                                                Table "public.ip_address_locations"
        Column        |           Type           |                                 Modifiers                                 | Storage
----------------------+--------------------------+---------------------------------------------------------------------------+---------
 network_start_ip     | inet                     |                                                                           | main    
 the_geom             | geometry(Geometry,4326)  |                                                                           | main    
 cartodb_id           | integer                  | not null default nextval('geolite2_city_blocks_cartodb_id_seq'::regclass) | plain   
 created_at           | timestamp with time zone | not null default now()                                                    | plain  
 updated_at           | timestamp with time zone | not null default now()                                                    | plain   
 the_geom_webmercator | geometry(Geometry,3857)  |                                                                           | main   
````

#### Current indexes

````
Indexes:
    "geolite2_city_blocks_pkey" PRIMARY KEY, btree (cartodb_id)
    "geolite2_city_blocks_the_geom_idx" gist (the_geom)
    "geolite2_city_blocks_the_geom_webmercator_idx" gist (the_geom_webmercator)
    "idx_ip_address_locations_start" btree (network_start_ip)
````

# Response data types
* geocode_ip_v1:
  `CREATE TYPE geocode_ip_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);`

# Data Sources

* GeoLite2 open source database [Created by MaxMind](http://www.maxmind.com) -
http://dev.maxmind.com/geoip/geoip2/geolite2/
    Download the CSV [Geolite2 City](http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip)
    - Coverage: global
    - Geometry type: point

# Testing
In order to test the data and the functions created under the script avaialble in this folder, you will need to run `bash test.sh` from `test/data` and `test/functions`.

# Known issues

# Historic:
* [01/12/2015]:
  * Removed geocoder function. Check /extensions instead.
* [19/10/2015]:
  * Updates README and adds usage example and definition of the service
* [08/10/2015]:
  * Added response data types
* [14/07/2015]:
  * Added tests
* [24/06/2015]:
  * Update readme.md: Adds Known issues section
  * Supervised function available in `geocoder.sql`
* [23/06/2015]:
  * Updates `README.md`: adds testing and table structure sections. Updates creation steps
  * Adding test structure for IP addresses geocoder
