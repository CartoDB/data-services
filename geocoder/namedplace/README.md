Named places geocoder
===============

# Function

````
SELECT (geocode_namedplace(Array['sunapee', 'sunapeeee', 'New York City'], 'USA')).*
`````

# Source table structure

**global_cities_points_limited**
````
                                                           Table "public.global_cities_points_limited"
        Column        |           Type           |                               Modifiers                               | Storage  | Stats target | Description 
----------------------+--------------------------+-----------------------------------------------------------------------+----------+--------------+-------------
 geoname_id           | double precision         |                                                                       | plain    |              | 
 name                 | text                     |                                                                       | extended |              | 
 asciiname            | text                     |                                                                       | extended |              | 
 altnames             | text                     |                                                                       | extended |              | 
 featclass            | text                     |                                                                       | extended |              | 
 featcode             | text                     |                                                                       | extended |              | 
 iso2                 | text                     |                                                                       | extended |              | 
 cc2                  | text                     |                                                                       | extended |              | 
 admin1               | text                     |                                                                       | extended |              | 
 admin2               | text                     |                                                                       | extended |              | 
 admin3               | text                     |                                                                       | extended |              | 
 admin4               | text                     |                                                                       | extended |              | 
 population           | double precision         |                                                                       | plain    |              | 
 gtopo30              | integer                  |                                                                       | plain    |              | 
 the_geom             | geometry(Point,4326)     |                                                                       | main     |              | 
 created_at           | timestamp with time zone | not null default now()                                                | plain    |              | 
 updated_at           | timestamp with time zone | not null default now()                                                | plain    |              | 
 the_geom_webmercator | geometry(Geometry,3857)  |                                                                       | main     |              | 
 cartodb_id           | integer                  | not null default nextval('points_cities_le_cartodb_id_seq'::regclass) | plain    |              | 
 lowername            | text                     |                                                                       | extended |              | 

````

**global_cities_alternates_limited**
````
                                                                 Table "public.global_cities_alternates_limited"
        Column        |           Type           |                                       Modifiers                                       | Storage  | Stats target | Description 
----------------------+--------------------------+---------------------------------------------------------------------------------------+----------+--------------+-------------
 geoname_id           | integer                  |                                                                                       | plain    |              | 
 name                 | text                     |                                                                                       | extended |              | 
 the_geom             | geometry(Geometry,4326)  |                                                                                       | main     |              | 
 created_at           | timestamp with time zone | not null default now()                                                                | plain    |              | 
 updated_at           | timestamp with time zone | not null default now()                                                                | plain    |              | 
 the_geom_webmercator | geometry(Geometry,3857)  |                                                                                       | main     |              | 
 preferred            | boolean                  |                                                                                       | plain    |              | 
 lowername            | text                     |                                                                                       | extended |              | 
 cartodb_id           | integer                  | not null default nextval('global_cities_alternates_limited_cartodb_id_seq'::regclass) | plain    |              | 
 admin1_geonameid     | integer                  |                                                                                       | plain    |              | 
 iso2                 | text                     |                                                                                       | extended |              | 
 admin1               | text                     |                                                                                       | extended |              | 

````

# Creation steps
1. Upload the allCountries and alternateNames tables
2. Generate the `global_cities_points_limited` and `global_cities_alternates_limited` tables
3. Run the `sql/build_data_table.sql` script to build the `global_cities_points_limited` table

**Note**: The generation script for `global_cities_alternates_limited` is missing.

# Data Sources

* Geonames free gazzeter data. `allCountries.zip` file available [here](http://download.geonames.org/export/dump/allCountries.zip). `alternateNames.zip` file available [here](http://download.geonames.org/export/dump/alternateNames.zip).

# Testing
In order to test the data and the functions created under the script avaialble in this folder, you will need to run `bash test.sh` from `test/data` and `test/functions`.

# Known issues
* Admin1 column with null rows doesn't return a result: https://github.com/CartoDB/data-services/issues/147
* The geocoding function is using a deprecated table: `admin1_decoder` instead of the new `admin1_synonyms`. Related issue: https://github.com/CartoDB/data-services/issues/148

# Historic:
* [24/06/2015]:
  * Added section "Known issues" 
* [23/06/2015]: 
  * `README.md` file generated
  * Added structure for `/test`

