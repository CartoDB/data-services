IP address geocoder
===============

# Function

````
SELECT geocode_ip(Array['1.0.16.0', '::ffff:1.0.16.0'])
`````

# Source table structure

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


# Creation steps
1. Create the `ip_address_locations` table
2. Obtain the file from http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip
3. Uncompress it and upload the `GeoLite2-City-Blocks-IPv4.csv` file
4. Rename the uploaded table as `latest_ip_address_locations`
5. Run the `sql/build_data_table` script to update the table

# Data Sources

GeoLite2 open source database [Created by MaxMind](http://www.maxmind.com) - 
http://dev.maxmind.com/geoip/geoip2/geolite2/ Download the CSV [Geolite2 City](http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip)

# Preparation details
This section doesn't require special processing.

# Testing
In order to test the data and the functions created under the script avaialble in this folder, you will need to run `bash test.sh` from `test/data` and `test/functions`.

# Historic:
* [23/06/2015]: 
  * Updates `README.md`
  * Adding test structure for IP addresses geocoder


