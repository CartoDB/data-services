Administrative regions geocoder - Level 0
===============

# Function

Accepts a list of terms. Terms are searched against the ```name_``` column in ```admin0_synonyms```. The ```name_``` column is an automatically cleaned and populated column based on the raw values in ```name_``` . The synonym table returns the proper ISO code (based on rank values in table below). The iso code is then matched against the single row in ```ne_admin0_v3``` to return the polygon.

# Creation steps

1. Upload fresh NaturalEarth data to ```ne_admin0_v3```.  The source file creates a table with the name `ne_10m_admin0_countries`.
2. Delete all rows in the ```admin0_synonyms``` table. 
3. If fresh, add all `sql/indexes.sql` and `sql/triggers.sql`
4. Upload the `data/wikipedia_countries_native_names.csv` table if it doesn't already exist
5. Run the `sql/subdivide_polygons.sql` 
6. Run the `sql/build_synonym_table.sql`
7. If needed, load or replace the function with `sql/geocoder.sql`

# Tables
#### admin0_synonyms

This table stores different synonyms per each country/region. It is populated through `sql/build_synonym_table.sql`.

##### Table stucture
````
                                                                 Table "public.admin0_synonyms"
        Column        |           Type           |                              Modifiers                               | Storage  | Stats target | Description 
----------------------+--------------------------+----------------------------------------------------------------------+----------+--------------+-------------
 name                 | text                     |                                                                      | extended |              | 
 rank                 | double precision         |                                                                      | plain    |              | 
 created_at           | timestamp with time zone | not null default now()                                               | plain    |              | 
 updated_at           | timestamp with time zone | not null default now()                                               | plain    |              | 
 the_geom             | geometry(Geometry,4326)  |                                                                      | main     |              | 
 the_geom_webmercator | geometry(Geometry,3857)  |                                                                      | main     |              | 
 cartodb_id           | integer                  | not null default nextval('admin0_synonyms_cartodb_id_seq'::regclass) | plain    |              | 
 adm0_a3              | text                     |                                                                      | extended |              | 
 name_                | text                     |                                                                      | extended |              | 

````

##### Current indexes
````
Indexes:
    "admin0_synonyms_pkey" PRIMARY KEY, btree (cartodb_id)
    "admin0_synonyms_cartodb_id_key" UNIQUE CONSTRAINT, btree (cartodb_id)
    "admin0_synonyms_the_geom_idx" gist (the_geom)
    "admin0_synonyms_the_geom_webmercator_idx" gist (the_geom_webmercator)
    "idx_admin0_synonyms_nam" btree (name)
    "idx_admin0_synonyms_name" btree (lower(regexp_replace(name, '\W+'::text, ''::text)))
    "idx_admin0_synonyms_name_" btree (name_)
    "idx_admin0_synonyms_name_patt" btree (name_ text_pattern_ops)
    "idx_admin0_synonyms_name_rank" btree (name_, rank)
    "idx_admin0_synonyms_rank" btree (rank)
````

#### ne_admin0_v3

This table stores the geometries. It's obtained from Natural Earth Data and curated afterwards with `sql/subdivide_polygons.sql`.

##### Table structure
```
                                                                        Table "public.ne_admin0_v3"
        Column        |           Type           |                                    Modifiers                                     | Storage  | Stats target | Description 
----------------------+--------------------------+----------------------------------------------------------------------------------+----------+--------------+-------------
 the_geom             | geometry(Geometry,4326)  |                                                                                  | main     |              | 
 scalerank            | integer                  |                                                                                  | plain    |              | 
 featurecla           | text                     |                                                                                  | extended |              | 
 labelrank            | double precision         |                                                                                  | plain    |              | 
 sovereignt           | text                     |                                                                                  | extended |              | 
 sov_a3               | text                     |                                                                                  | extended |              | 
 adm0_dif             | double precision         |                                                                                  | plain    |              | 
 level                | double precision         |                                                                                  | plain    |              | 
 type                 | text                     |                                                                                  | extended |              | 
 admin                | text                     |                                                                                  | extended |              | 
 adm0_a3              | text                     |                                                                                  | extended |              | 
 geou_dif             | double precision         |                                                                                  | plain    |              | 
 geounit              | text                     |                                                                                  | extended |              | 
 gu_a3                | text                     |                                                                                  | extended |              | 
 su_dif               | double precision         |                                                                                  | plain    |              | 
 subunit              | text                     |                                                                                  | extended |              | 
 su_a3                | text                     |                                                                                  | extended |              | 
 brk_diff             | double precision         |                                                                                  | plain    |              | 
 name                 | text                     |                                                                                  | extended |              | 
 name_long            | text                     |                                                                                  | extended |              | 
 brk_a3               | text                     |                                                                                  | extended |              | 
 brk_name             | text                     |                                                                                  | extended |              | 
 brk_group            | text                     |                                                                                  | extended |              | 
 abbrev               | text                     |                                                                                  | extended |              | 
 postal               | text                     |                                                                                  | extended |              | 
 formal_en            | text                     |                                                                                  | extended |              | 
 formal_fr            | text                     |                                                                                  | extended |              | 
 note_adm0            | text                     |                                                                                  | extended |              | 
 note_brk             | text                     |                                                                                  | extended |              | 
 name_sort            | text                     |                                                                                  | extended |              | 
 name_alt             | text                     |                                                                                  | extended |              | 
 mapcolor7            | double precision         |                                                                                  | plain    |              | 
 mapcolor8            | double precision         |                                                                                  | plain    |              | 
 mapcolor9            | double precision         |                                                                                  | plain    |              | 
 mapcolor13           | double precision         |                                                                                  | plain    |              | 
 pop_est              | double precision         |                                                                                  | plain    |              | 
 gdp_md_est           | double precision         |                                                                                  | plain    |              | 
 pop_year             | double precision         |                                                                                  | plain    |              | 
 lastcensus           | double precision         |                                                                                  | plain    |              | 
 gdp_year             | double precision         |                                                                                  | plain    |              | 
 economy              | text                     |                                                                                  | extended |              | 
 income_grp           | text                     |                                                                                  | extended |              | 
 wikipedia            | double precision         |                                                                                  | plain    |              | 
 fips_10_             | text                     |                                                                                  | extended |              | 
 iso_a2               | text                     |                                                                                  | extended |              | 
 iso_a3               | text                     |                                                                                  | extended |              | 
 iso_n3               | text                     |                                                                                  | extended |              | 
 un_a3                | text                     |                                                                                  | extended |              | 
 wb_a2                | text                     |                                                                                  | extended |              | 
 wb_a3                | text                     |                                                                                  | extended |              | 
 woe_id               | double precision         |                                                                                  | plain    |              | 
 woe_id_eh            | double precision         |                                                                                  | plain    |              | 
 woe_note             | text                     |                                                                                  | extended |              | 
 adm0_a3_is           | text                     |                                                                                  | extended |              | 
 adm0_a3_us           | text                     |                                                                                  | extended |              | 
 adm0_a3_un           | double precision         |                                                                                  | plain    |              | 
 adm0_a3_wb           | double precision         |                                                                                  | plain    |              | 
 continent            | text                     |                                                                                  | extended |              | 
 region_un            | text                     |                                                                                  | extended |              | 
 subregion            | text                     |                                                                                  | extended |              | 
 region_wb            | text                     |                                                                                  | extended |              | 
 name_len             | double precision         |                                                                                  | plain    |              | 
 long_len             | double precision         |                                                                                  | plain    |              | 
 abbrev_len           | double precision         |                                                                                  | plain    |              | 
 tiny                 | double precision         |                                                                                  | plain    |              | 
 homepart             | double precision         |                                                                                  | plain    |              | 
 cartodb_id           | integer                  | not null default nextval('ne_10m_admin_0_countries_1_cartodb_id_seq1'::regclass) | plain    |              | 
 created_at           | timestamp with time zone | not null default now()                                                           | plain    |              | 
 updated_at           | timestamp with time zone | not null default now()                                                           | plain    |              | 
 the_geom_webmercator | geometry(Geometry,3857)  |                                                                                  | main     |              | 

````
##### Current indexes
````
Indexes:
    "ne_10m_admin_0_countries_1_pkey1" PRIMARY KEY, btree (cartodb_id)
    "idx_ne_admin0_v3_adm0_a3" UNIQUE, btree (adm0_a3)
    "ne_10m_admin_0_countries_1_cartodb_id_key" UNIQUE CONSTRAINT, btree (cartodb_id)
    "idx_ne_admin0_v3_a3" btree (adm0_a3)
    "ne_10m_admin_0_countries_1_the_geom_webmercator_idx" gist (the_geom_webmercator)
    "the_geom_4e1a2710_110a_11e4_b0ba_7054d21a95e5" gist (the_geom)
````

# Related functions

* geocode_admin0_polygons

```
 Schema |          Name           |    Result data type    | Argument data types |  Type  
--------+-------------------------+------------------------+---------------------+--------
 public | geocode_admin0_polygons | SETOF geocode_admin_v1 | name text[]         | normal
```

* admin0_synonym_lookup - Related with admin0 synonym service, see below

````
 Schema |         Name          |    Result data type     | Argument data types |  Type  
--------+-----------------------+-------------------------+---------------------+--------
 public | admin0_synonym_lookup | SETOF synonym_lookup_v1 | name text[]         | normal
````

* [admin0_available_services](https://github.com/CartoDB/data-services/blob/master/geocoder/available-services/sql/services.sql) - available in `geocoder/available-services`

````
 Schema |           Name            |      Result data type       | Argument data types |  Type  
--------+---------------------------+-----------------------------+---------------------+--------
 public | admin0_available_services | SETOF available_services_v1 | name text[]         | normal
````


# Data Sources

(see the wiki page: [Geocoder Data Sources #admin0-countries](https://github.com/CartoDB/data-services/wiki/Geocoder-Datasources#admin0-countries))

- natural earth data: ne_10m_admin_0_countries (version 3.0) which is currently stored in Geocoding.CartoDB as ne_admin0_v3. This is stored in data/ne_10m_admin_0_countries.zip

- native language spellings were gathered from http://en.wikipedia.org/wiki/List_of_countries_and_dependencies_and_their_capitals_in_native_languages and stored in data/wikipedia_countries_native_names.csv

- ISO 3166-2 codes were gathered from http://en.wikipedia.org/wiki/ISO_3166-2 and stored in data/wikipedia_iso_3166_2.csv

# Preparation details

Users dislike the NaturalEarth aggregation of French regions into the mainland France polygon. We have done a minimal amount of subdivision. This can be done by executing `sql/subdivide_polygons.sql`.

## Admin0_synonyms

In order to add new entries manually for admin0, table [admin0_synonym_additions](https://geocoding.cartodb.com/tables/admin0_synonym_additions) has been created.

The table contains the following columns to be populated:

1. **adm0_a3** : ISO code for the region. Used to get the unique geometry for the region in terms of the synonym.

2. **name**: Actually, the synonym you want to include for a specific region (identified ad adm0_a3).

3. **notes:** Extra information as the source of the data. Use: 'data source: X'.

4. **rank:** Use '10' for manually curated additions.

The following query can be used:


````
INSERT INTO admin0_synonym_additions (adm0_a3, name, notes, rank) VALUES ($iso3_code, $synonym, $notes, 10)
````

**Note:** If you have a complete dataset of synonyms to be included, you will need to add it as part of the build script. If you need to add single entries for synonyms, they can be included in the `admin0_synonym_additions` table manually (or using the previously defined SQL query).

### Ranks

| rank number | origin data                 | origin column | description          |
|-------------|-----------------------------|---------------|----------------------|
| 0           | natural earth 10m countries | name          | literal name     |
| 1           | natural earth 10m countries | name_alt      | alternate name       |
| 2           | wiki country navive names   | country_endonym |   local variation     |
| 3           | natural earth 10m countries | adm0_a3       | 3 digit country code |
| 4           | wikipedia iso 3166 2 codes | iso_a2     | 2 digit country code        |
| 5           | natural earth 10m countries | formal_en     | formal english       |
| 6           | natural earth 10m countries | brk_name      | ?                    |
| 7           | natural earth 10m countries | formal_fr     | formal french        |
| 8           | natural earth 10m countries | abbrev        | abbreviation         |
| 9           | natural earth 10m countries | subunit     | complete literal name       |
| 10           | admin0_synonym_additions | n/a     | manually curated additions       |


__notes:__ 

- The column `adm0_a3` will be used as a unique identifier.
- The ranks are somewhat arbitrarily organized and should be modified later based on our users use of the geocoder (will users more commonly geocode an adm0_a3 or abbreviation?) 
- I also forgot to assign a `rank` of `2` to a synonym.

# Admin0 Synonym Service

If you need to look up the iso code for any list of countries without returning any geometries, you can use the endpoint defined in sql/synonym_service.sql. An example works like this,

```sql
SELECT (admin0_synonym_lookup(Array['United States', 'ESP'])).*
```

# Testing

In order to test the data and the functions created under the script avaialble in this folder, you will need to run `bash test.sh` from `test/data` and `test/functions`. These functions test the amount of geometries generated, their bounding box, and the bounding box of the results generated by the geocoder functions. The tests also ensure a minimum quality in the synonyms table/function, checking that the official name (in English) for the regions is recognised.

# Known issues

# Historic
* [14/07/2015]:
  * Added tests 
* [03/07/2015]:
  * Added "U.S. Virgin Islands" (normalised) as synonym of VIR 
* [24/06/2015]: 
  * Added table structure and index information
  * Adds known issues section
  * [Adds](https://github.com/CartoDB/data-services/pull/149/) `admin0_synonym_lookup` function 
* [23/06/2015]: 
  * Change of SQL code in `subdivide_polygons.sql` in order to create all of them with ST_Collect, which makes uniform the geometry types: ST_MultiPolygon
  * Uploaded basic tests for administrative regions of level 0 geocoder
  * Updated Testing section of `README.md`
* [22/06/2015]: 
  * Removes code that provokes an empty geometry for `IOA`, which was being stored as a null geometry. [PR 144](https://github.com/CartoDB/data-services/pull/144)
