Level 1 Administrative regions geocoder
============

# Function

Accepts a list of terms. Terms are searched against the `name_` column in `admin1_synonyms_qs`. The `name_` column is an automatically cleaned and populated column based on the raw values in `name` . The synonym table returns the proper global_id (based on rank values in table below). The global_id is then matched against the single row in the **adm1** table to return the correct polygon(s).

# Usage example

```sql
SELECT (geocode_admin1_polygons(Array['Alicante', 'California'], Array['Spain', 'USA'])).*
```

# Creation steps

1. Upload fresh Quattro Shapes admin1 data to `qs_adm1` table.
2. Upload fresh Quattro Shapes admin1 **region** data to `qs_adm1_region` table.
3. Upload fresh Natural Earth admin1 states provinces data to `ne_admin1_v3`
3. If fresh, add all `sql/indexes.sql` and `sql/triggers.sql`
4. Run the `sql/build_data_table.sql` script.
5. Run the `sql/build_admin1_synonyms.sql` script.
6. If needed, load or replace the function with `sql/geocoder.sql`

# Tables

Some tables involved in the creation of this geocoder which are not used by the geocoder functions are `qs_adm1`, `ne_admin1_v3` and  `qs_adm1_region`, which are obtained directly from the source.

### admin1_synonyms
#### Table structure
````
                                                                 Table "public.admin1_synonyms"
        Column        |           Type           |                               Modifiers                               | Storage  | Stats target | Description
----------------------+--------------------------+-----------------------------------------------------------------------+----------+--------------+-------------
 cartodb_id           | integer                  | not null default nextval('untitled_table_1_cartodb_id_seq'::regclass) | plain    |              |
 name                 | text                     |                                                                       | extended |              |
 rank                 | double precision         |                                                                       | plain    |              |
 created_at           | timestamp with time zone | not null default now()                                                | plain    |              |
 updated_at           | timestamp with time zone | not null default now()                                                | plain    |              |
 the_geom             | geometry(Geometry,4326)  |                                                                       | main     |              |
 the_geom_webmercator | geometry(Geometry,3857)  |                                                                       | main     |              |
 adm0_a3              | text                     |                                                                       | extended |              |
 name_                | text                     |                                                                       | extended |              |
 global_id            | integer                  |                                                                       | plain    |              |

````

#### Current indexes
````
Indexes:
    "untitled_table_1_pkey" PRIMARY KEY, btree (cartodb_id)
    "idx_admin1_synonyms_name" btree (name)
    "idx_admin1_synonyms_name_" btree (name_)
    "idx_admin1_synonyms_name_adm0" btree (name_, adm0_a3)
    "idx_admin1_synonyms_rank" btree (rank)
    "untitled_table_1_the_geom_idx" gist (the_geom)
    "untitled_table_1_the_geom_webmercator_idx" gist (the_geom_webmercator)
````
### adm1
#### Table structure
````
                                                                       Table "public.adm1"
        Column        |           Type           |                               Modifiers                                | Storage  | Stats target | Description
----------------------+--------------------------+------------------------------------------------------------------------+----------+--------------+-------------
 cartodb_id           | integer                  | not null default nextval('untitled_table_2_cartodb_id_seq1'::regclass) | plain    |              |
 name                 | text                     |                                                                        | extended |              |
 description          | text                     |                                                                        | extended |              |
 created_at           | timestamp with time zone | not null default now()                                                 | plain    |              |
 updated_at           | timestamp with time zone | not null default now()                                                 | plain    |              |
 the_geom             | geometry(Geometry,4326)  |                                                                        | main     |              |
 the_geom_webmercator | geometry(Geometry,3857)  |                                                                        | main     |              |
 global_id            | integer                  |                                                                        | plain    |              |

````
#### Current indexes
````
Indexes:
    "untitled_table_2_pkey1" PRIMARY KEY, btree (cartodb_id)
    "untitled_table_2_the_geom_idx1" gist (the_geom)
    "untitled_table_2_the_geom_webmercator_idx1" gist (the_geom_webmercator)
````

### admin1_synonyms
#### Table structure
````
                                                                 Table "public.admin1_synonyms"
        Column        |           Type           |                               Modifiers                               | Storage  | Stats target | Description
----------------------+--------------------------+-----------------------------------------------------------------------+----------+--------------+-------------
 cartodb_id           | integer                  | not null default nextval('untitled_table_1_cartodb_id_seq'::regclass) | plain    |              |
 name                 | text                     |                                                                       | extended |              |
 rank                 | double precision         |                                                                       | plain    |              |
 created_at           | timestamp with time zone | not null default now()                                                | plain    |              |
 updated_at           | timestamp with time zone | not null default now()                                                | plain    |              |
 the_geom             | geometry(Geometry,4326)  |                                                                       | main     |              |
 the_geom_webmercator | geometry(Geometry,3857)  |                                                                       | main     |              |
 adm0_a3              | text                     |                                                                       | extended |              |
 name_                | text                     |                                                                       | extended |              |
 global_id            | integer                  |                                                                       | plain    |              |

````

#### Current indexes
````
Indexes:
    "untitled_table_1_pkey" PRIMARY KEY, btree (cartodb_id)
    "idx_admin1_synonyms_name" btree (name)
    "idx_admin1_synonyms_name_" btree (name_)
    "idx_admin1_synonyms_name_adm0" btree (name_, adm0_a3)
    "idx_admin1_synonyms_rank" btree (rank)
    "untitled_table_1_the_geom_idx" gist (the_geom)
    "untitled_table_1_the_geom_webmercator_idx" gist (the_geom_webmercator)
````

### admin1_decoder - planned deprecation
#### Table structure
`````
                                                                 Table "public.admin1_decoder"
        Column        |           Type           |                              Modifiers                              | Storage  | Stats target | Description
----------------------+--------------------------+---------------------------------------------------------------------+----------+--------------+-------------
 name                 | text                     |                                                                     | extended |              |
 admin1               | text                     |                                                                     | extended |              |
 iso2                 | text                     |                                                                     | extended |              |
 geoname_id           | integer                  |                                                                     | plain    |              |
 cartodb_id           | integer                  | not null default nextval('admin1_decoder_cartodb_id_seq'::regclass) | plain    |              |
 created_at           | timestamp with time zone | not null default now()                                              | plain    |              |
 updated_at           | timestamp with time zone | not null default now()                                              | plain    |              |
 the_geom             | geometry(Geometry,4326)  |                                                                     | main     |              |
 the_geom_webmercator | geometry(Geometry,3857)  |                                                                     | main     |              |
 synonyms             | text[]                   |                                                                     | extended |              |
 iso3                 | text                     |                                                                     | extended |              |
 users                | double precision         |                                                                     | plain    |              |

`````

#### Current indexes
`````
Indexes:
    "admin1_decoder_pkey" PRIMARY KEY, btree (cartodb_id)
    "admin1_decoder_the_geom_idx" gist (the_geom)
    "idx_admin1_decoder_admin1" btree (admin1)
    "idx_admin1_decoder_geoname_id" btree (geoname_id)
    "idx_admin1_decoder_iso2" btree (iso2)
    "idx_admin1_decoder_iso3" btree (iso3)
    "idx_admin1_decoder_name" btree (name)
    "the_geom_webmercator_3b4ba2fe_9d91_11e3_bb72_7054d21a95e5" gist (the_geom_webmercator)
`````

# Functions
## test_geocode_admin1_polygons
````
 Schema |             Name             |        Result data type        |      Argument data types       |  Type  
--------+------------------------------+--------------------------------+--------------------------------+--------
 public | test_geocode_admin1_polygons | SETOF geocode_admin_country_v1 | names text[], country text[]   | normal
 public | test_geocode_admin1_polygons | SETOF geocode_admin_v1         | name text[]                    | normal
 public | test_geocode_admin1_polygons | SETOF geocode_admin_country_v1 | name text[], inputcountry text | normal
 ````

# Response data types
* geocode_admin_country_v1:
  `CREATE TYPE geocode_admin_country_v1 AS (q TEXT, c TEXT, geom GEOMETRY, success BOOLEAN);`
* geocode_admin_v1:
  `CREATE TYPE geocode_admin_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);`

# Data Sources

(see the wiki page: [Geocoder Data Sources #admin1-states-provinces](https://github.com/CartoDB/data-services/wiki/Geocoder-Datasources#admin1-statesprovinces))

- **Quattro Shapes** admin1 and admin1 region polygons are being used for geometry. Users dislike natural earth's small admin1 units in countries like Spain, Italy and France so we have replaced these smaller units with their parent regions.
  - Quattro Shapes admin1: http://static.quattroshapes.com/qs_adm1.zip
    - Coverage: global
    - Geometry type: polygon
  - Quattro Shapes admin1 regions: http://static.quattroshapes.com/qs_adm1_region.zip
    - Coverage: global
    - Geometry type: polygon


- **Natural Earth Data** admin1 states provinces: http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_1_states_provinces.zip
  - Coverage: global
  - Geometry type: polygon

  _Note: Natural Earth admin1 alternate name spellings will be used as synonyms when the Quattro Shapes `qs_source` = 'Natural Earth'._

# Admin1 Geometry Table
The table name is currently being called `adm1` and is built from a combination of data from Quattro Shapes: `qs_adm1` and `qs_adm1_region`. All countries that contain regional admin1 provinces use geometry from the `qs_adm1_region` table and not the `qs_adm1` table. This is an improvement made based on tickets/issues submitted by users when geocoding admin1 states / provinces.


# Admin1 Synonyms Table

The table contains the following columns to be populated:

1. **adm0_a3** : ISO code for the region. Used to get the unique geometry for the region in terms of the synonym.

2. **name**: Actually, the synonym you want to include for a specific region (identified ad adm0_a3).

4. **rank**: Rank of the synonym being matched to. 0 is highest.

5. **global_id** Unique identifier created in `build_data_table.sql`.

# Ranks

| rank number | origin data                 | origin column | description          |
|-------------|-----------------------------|---------------|----------------------|
| 0			  | Quattro Shapes				| qs_a1 | default name for qs_adm1 |
| 0				| Quattro Shapes			| qs_a1r | default name for qs_adm1_region |
| 1				| Quattro Shapes			| qs_a1_lc | admin code |
| 2 			| Natural Earth 			| name_alt | alternate spelling |
| 3				| Natural Earth				| abbrev   | abbreviation |
| 4				| Natural Earth				| postal   | postal code  |
| 5 			| Natural Earth 			| gn_name  | formal english name  |
| 6 			| Natural Earth 			| woe_label  | woe label name  | 	
| 7 			| TIGER 		 			| stusps  | Abbreviation (USA only)  | 	

# Deprecated ADM1 geocoder
## Source table:   
- Natural Earth Data admin1 states provinces: http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_1_states_provinces.zip which can be replaced by the version without large lakes: http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_1_states_provinces_lakes.zip

## Tables:
- global_province_polygons

## Generation steps:
1. Upload Natural Earth Data admin1 states provinces
2. Rename `adm0_a3` by `iso3`, add columns `frequency` [number] (To calculate frequency, I simply counted the number of users we had signed up in each country. Countries with more users, we favor higher in the geocoder :)) and `synonyms` [string[]]  
3. In order to fill the `synonyms` column, you can run the following query:
`UPDATE tablename SET synonyms = Array[lower(woe_name), lower(name), lower(gns_name), lower(gn_name), lower(gn_a1_code), lower(code_hasc), lower(adm1_code), lower(adm1_cod_1), lower(postal)]`
4. Rename table to `global_province_polygons`

## Functions:
### geocode_admin1_polygons
````
 Schema |          Name           |        Result data type        |      Argument data types       |  Type  
--------+-------------------------+--------------------------------+--------------------------------+--------
 public | geocode_admin1_polygons | SETOF geocode_admin_country_v1 | names text[], country text[]   | normal
 public | geocode_admin1_polygons | SETOF geocode_admin_v1         | name text[]                    | normal
 public | geocode_admin1_polygons | SETOF geocode_admin_v1         | name text[], inputcountry text | normal
 ````


# Known issues
* `admin1_decoder` table which is meant to be depreacted is being used in other geocoders, as namedplaces
* All the information in this README.md doesn't contain the actual status of the CartoDB geocoder, which is using the table `global_province_polygons` documented in the deprecated ADM1 geocoder section.
* In Italy, provinces are being shown instead of ADMIN1 regions. The same happened with Spain, which is manually fixed.

# Historic:
* [19/10/2015]:
  * Updates on README + Adding usage examples
* [08/10/2015]:
  * Added response types
* [14/07/2015]:
  * Added tests
* [02/07/2015]
  * Includes section for deprecated admin1 geocoder
* [24/06/2015]:
  * Updated Readme: add information for tables, functions, indexes and known issues section
  * Reviewed functions and [uploaded the ones in production](https://github.com/CartoDB/data-services/pull/151)
