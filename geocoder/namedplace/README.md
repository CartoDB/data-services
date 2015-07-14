Named places geocoder
===============

# Function

````
SELECT (geocode_namedplace(Array['sunapee', 'sunapeeee', 'New York City'], 'USA')).*
`````

# Creation steps
1. Download the allCountries and alternateNames tables from the source
2. In order to clean the files from characters that may provoke issues in the importation to CartoDB, please run in your terminal: `sed 's/"//' filename.txt > filename.out.txt`
3. Import the zipped files for allCountries and alternateNames once processed
4. Generate the `global_cities_points_limited` and `global_cities_alternates_limited` tables
5. Run the `sql/build_data_table.sql` script to build the `global_cities_points_limited` table


# Tables

### global_cities_points_limited

#### Table structure
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

#### Current indexes

````
Indexes:
    "points_cities_le_pkey" PRIMARY KEY, btree (cartodb_id)
    "points_cities_le_cartodb_id_key" UNIQUE CONSTRAINT, btree (cartodb_id)
    "idx_global_cities_points_lim_a" btree (lowername, iso2)
    "idx_global_cities_points_lim_admin1" btree (admin1)
    "idx_global_cities_points_lim_geoname_id" btree (geoname_id)
    "points_cities_le_the_geom_idx" gist (the_geom)
    "points_cities_le_the_geom_webmercator_idx" gist (the_geom_webmercator)
````

### global_cities_alternates_limited
#### Table structure
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

#### Current indexes

````
Indexes:
    "global_cities_alternates_limited_pkey" PRIMARY KEY, btree (cartodb_id)
    "global_cities_alternates_limited_the_geom_idx" gist (the_geom)
    "global_cities_alternates_limited_the_geom_webmercator_idx" gist (the_geom_webmercator)
    "idx_global_cities_alternates_limited_admin1" btree (admin1)
    "idx_global_cities_alternates_limited_admin1_geonameid" btree (admin1_geonameid)
    "idx_global_cities_alternates_limited_lowername" btree (lowername)
`````
# Related functions

### geocode_namedplace 

````
 Schema |        Name        |          Result data type           |                Argument data types                 |  Type  
--------+--------------------+-------------------------------------+----------------------------------------------------+--------
 public | geocode_namedplace | SETOF geocode_namedplace_v1         | places text[]                                      | normal
 public | geocode_namedplace | SETOF geocode_admin1_country_v1     | places text[], admin1s text, inputcountry text     | normal
 public | geocode_namedplace | SETOF geocode_admin1_country_v1     | places text[], admin1s text[], inputcountry text   | normal
 public | geocode_namedplace | SETOF geocode_admin1_country_v1     | places text[], admin1s text[], inputcountry text[] | normal
 public | geocode_namedplace | SETOF geocode_namedplace_country_v1 | places text[], country text[]                      | normal
 public | geocode_namedplace | SETOF geocode_admin_country_v1      | places text[], inputcountry text                   | normal
 ````
 
### geocode_namedplace_country 
````
 Schema |            Name            |          Result data type           |      Argument data types      |  Type  
--------+----------------------------+-------------------------------------+-------------------------------+--------
 public | geocode_namedplace_country | SETOF geocode_namedplace_country_v1 | places text[], country text[] | normal
 ````

# Data Sources

* Geonames free gazzeter data. `allCountries.zip` file available [here](http://download.geonames.org/export/dump/allCountries.zip). `alternateNames.zip` file available [here](http://download.geonames.org/export/dump/alternateNames.zip).

## Fields (from GeoNames database)

| column name | meaning |
|-------------|---------|
| geonameid   | integer id of record in geonames database   |
| name        | name of geographical point (utf8) varchar(200)     |
| asciiname   | name of geographical point in plain ascii characters, varchar(200)   |
| alternatenames  | alternatenames, comma separated, ascii names automatically transliterated, convenience attribute from alternatename table, varchar(10000) |
| latitude      | latitude in decimal degrees (wgs84)   |
| longitude     | longitude in decimal degrees (wgs84)    |
| feature class | see http://www.geonames.org/export/codes.html, char(1)    |
| feature code  | see http://www.geonames.org/export/codes.html, varchar(10)    |
| country code  | ISO-3166 2-letter country code, 2 characters    |
| cc2           | alternate country codes, comma separated, ISO-3166 2-letter country code, 200 characters   |
| admin1 code   | fipscode (subject to change to iso code), see exceptions below, see file admin1Codes.txt for display names of this code; varchar(20) |
| admin2 code   | code for the second administrative division, a county in the US, see file admin2Codes.txt; varchar(80) | 
| admin3 code   | code for third level administrative division, varchar(20) |
| admin4 code   | code for fourth level administrative division, varchar(20) |
| population    | bigint (8 byte int) |
| elevation     | in meters, integer |
| dem           | digital elevation model, srtm3 or gtopo30, average elevation of 3''x3'' (ca 90mx90m) or 30''x30'' (ca 900mx900m) area in meters, integer.  |
| timezone      | the timezone id (see file timeZone.txt) varchar(40) |
| modification date | date of last modification in yyyy-MM-dd format |



# Testing
In order to test the data and the functions created under the script avaialble in this folder, you will need to run `bash test.sh` from `test/data` and `test/functions`.

# Known issues
* Admin1 column with null rows doesn't return a result: https://github.com/CartoDB/data-services/issues/147
* The geocoding function is using a deprecated table: `admin1_decoder` instead of the new `admin1_synonyms`. Related issue: https://github.com/CartoDB/data-services/issues/148
* The name of the countries added in a column are not being sanitized https://github.com/CartoDB/cartodb/issues/3392
* The generation script for `global_cities_alternates_limited` is missing.
* Needs a better approach for synonyms and normalisation

# Historic:
* [14/07/2015]:
  * Updated README: Known issues
  * Added tests
* [24/06/2015]:
  * Added section "Known issues" 
  * Added table, functions and indexes information
  * Reviewed functions in the sql file. [Added this one](https://github.com/CartoDB/data-services/pull/150)
* [23/06/2015]: 
  * `README.md` file generated
  * Added structure for `/test`

