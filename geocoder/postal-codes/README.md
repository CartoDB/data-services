Postal code geocoder
===============

This section is divided in geocoding postal codes as points or as polygons. Each option has its own sources and its own functions which are  described below.

# Postal code geocoder: Polygons
## Function

By following the next steps a table is populated with zipcodes from Australia, Canada, USA and France (identified by iso3) related with their spatial location in terms of polygons.

## Usage example

```sql
SELECT (geocode_postalcode_polygons(Array['11211'],Array['USA'])).*
```

## Creation steps

1. Import the four files attached in the section "Datasources" for Australia (`doc` table), Canada (`gfsa000a11a_e` table), USA (`tl_2013_us_zcta510` table) and France (`codes_postaux` table, renamed from `codes_postaux_region`).

2. Run `sql/build_data_table.sql`. Notice that table `postal_code_polygons` should exist in advance with columns: `the_geom`, `adm0_a3` and `postal_code`.

## Tables
### postal_code_polygons
#### Table structure
````
                                                              Table "public.postal_code_polygons"
        Column        |           Type           |                               Modifiers                               | Storage  | Stats target | Description
----------------------+--------------------------+-----------------------------------------------------------------------+----------+--------------+-------------
 cartodb_id           | integer                  | not null default nextval('untitled_table_2_cartodb_id_seq'::regclass) | plain    |              |
 postal_code          | text                     |                                                                       | extended |              |
 adm0_a3              | text                     |                                                                       | extended |              |
 created_at           | timestamp with time zone | not null default now()                                                | plain    |              |
 updated_at           | timestamp with time zone | not null default now()                                                | plain    |              |
 the_geom             | geometry(Geometry,4326)  |                                                                       | main     |              |
 the_geom_webmercator | geometry(Geometry,3857)  |                                                                       | main     |              |

````

#### Current indexes
````
Indexes:
    "untitled_table_2_pkey" PRIMARY KEY, btree (cartodb_id)
    "idx_postal_code_polygons_a3_code" UNIQUE, btree (adm0_a3, postal_code)
    "untitled_table_2_the_geom_idx" gist (the_geom)
    "untitled_table_2_the_geom_webmercator_idx" gist (the_geom_webmercator)
````


## Related functions

### geocode_postalcode_polygons
````
 Schema |            Name             |          Result data type           |          Argument data types          |  Type  
--------+-----------------------------+-------------------------------------+---------------------------------------+--------
 public | geocode_postalcode_polygons | SETOF geocode_postalint_country_v1  | code integer[], inputcountries text[] | normal
 public | geocode_postalcode_polygons | SETOF geocode_namedplace_v1         | code text[]                           | normal
 public | geocode_postalcode_polygons | SETOF geocode_namedplace_country_v1 | code text[], inputcountries text[]    | normal
 public | geocode_postalcode_polygons | SETOF geocode_namedplace_v1         | code text[], inputcountry text        | normal
````


## Response data types
* geocode_namedplace_country_v1:
  `CREATE TYPE geocode_namedplace_country_v1 AS (q TEXT, c TEXT, geom GEOMETRY, success BOOLEAN);`
* geocode_namedplace_v1:
  `CREATE TYPE geocode_namedplace_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);`
* geocode_postalint_country_v1:
  `CREATE TYPE geocode_postalint_country_v1 AS (q INT, c TEXT, geom GEOMETRY, success BOOLEAN);`

## Data Sources

* Australian polygons - http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/2033.0.55.0012011?OpenDocument - Download the KMZ for *Postal Area IRSD, SEIFA 2011*. Unzip and upload the kmz
  - Coverage: AUS
  - Geometry type: polygon

* Canadian polygons - http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2011-eng.cfm - Download ESRI Shp, Forward Sortation Areas, Digital Boundary
  - Coverage: CAN
  - Geometry type: polygon

* USA polygons - http://www2.census.gov/geo/tiger/TIGER2013/ZCTA5/tl_2013_us_zcta510.zip
  - Coverage: USA
  - Geometry type: polygon

* French polygons - http://www.data.gouv.fr/dataset/fond-de-carte-des-codes-postaux
  - Coverage: FRA
  - Geometry type: polygon

# Postal code geocoder: Points

## Function

By following the next steps a table is populated with zipcodes of different countries (identified by iso3) related with their spatial location in terms of points.

This dataset includes data for the following countries:

````
CH, ES, GU, ZA, MX, SJ, NL, RU, AX, TH, AR, MY, RE, LK, GB, IS, GL, JE, DK, IN,
SI, GP, MQ, BR, SM, BG, NZ, MP, CZ, DO, MD, PK, TR, VI, BD, GG, LT, PM, MC, US,
IT, LU, SK, LI, PR, IM, NO, PT, PL, FI, JP, CA, DE, HU, PH, SE, VA, YT, MK, FR,
MH, RO, FO, GF, AD, HR, DZ, GT, AU, AS, BE, AT
````

## Usage example

```sql
SELECT (geocode_postalcode_points(Array['03204'],Array['ESP'])).*
```

## Creation steps

1. Download the allCountries.zip file from [GeoNames](www.geonames.org). Import and rename the table as `tmp_zipcode_points`. You can follow the manual process explained below instead.

  The columns that are loaded are the following ones:
  `field_1`: corresponding to ISO2
  `field_10`: corresponds to latitude
  `field_11`: corresponds to longitude
  `field_2`: corresponds to ZIP code

2. Georeference the table using `field11` as longitude and `field10` as latitude in order to construct `the_geom`.

3. Add column `iso3 (text)` and run `sql/build_zipcode_points_table.sql`.


**Alternative manual process for importing and preprocessing**

1. Open the `allCountries.txt` file with Excel an add a new row on top. Delete columns C-I and L.

2. In the first row, add the following columns: `iso2`, `zipcode`, `lat`, `long`.

3. Import the file ignoring step 2.

## Tables
### postal_code_points
#### Table structure
````
                                                                Table "public.postal_code_points"
        Column        |           Type           |                               Modifiers                                | Storage  | Stats target | Description
----------------------+--------------------------+------------------------------------------------------------------------+----------+--------------+-------------
 cartodb_id           | integer                  | not null default nextval('untitled_table_2_cartodb_id_seq2'::regclass) | plain    |              |
 adm0_a3              | text                     |                                                                        | extended |              |
 postal_code          | text                     |                                                                        | extended |              |
 created_at           | timestamp with time zone | not null default now()                                                 | plain    |              |
 updated_at           | timestamp with time zone | not null default now()                                                 | plain    |              |
 the_geom             | geometry(Geometry,4326)  |                                                                        | main     |              |
 the_geom_webmercator | geometry(Geometry,3857)  |                                                                        | main     |              |
````
#### Current indexes
````
    "untitled_table_2_pkey2" PRIMARY KEY, btree (cartodb_id)
    "untitled_table_2_the_geom_idx2" gist (the_geom)
    "untitled_table_2_the_geom_webmercator_idx2" gist (the_geom_webmercator)
````

## Related functions
### geocode_postalcode_points
````
 Schema |           Name            |          Result data type          |          Argument data types          |  Type  
--------+---------------------------+------------------------------------+---------------------------------------+--------
 public | geocode_postalcode_points | SETOF geocode_postalint_country_v1 | code integer[], inputcountries text[] | normal
 public | geocode_postalcode_points | SETOF geocode_namedplace_v1        | code text[]                           | normal
 public | geocode_postalcode_points | SETOF geocode_place_country_iso_v1 | code text[], inputcountries text[]    | normal
 public | geocode_postalcode_points | SETOF geocode_namedplace_v1        | code text[], inputcountry text        | normal
`````

## Data Sources

* All countries points [GeoNames](www.geonames.org) - http://download.geonames.org/export/zip/allCountries.zip
  - Coverage: See details at function description
  - Geometry type: point

# Geocoder coverage map
![Map](https://camo.githubusercontent.com/483eae203445096ffa8bf0fe3d92a99fd9367a01/68747470733a2f2f646c2e64726f70626f7875736572636f6e74656e742e636f6d2f752f323837393330382f53637265656e25323053686f74253230323031352d30362d3239253230617425323031342e30332e34342e706e67)
# Known issues:
* The name of the countries added in a column are not being sanitized https://github.com/CartoDB/cartodb/issues/3392
* Incorrect table usage for polygons and free text https://github.com/CartoDB/data-services/issues/173

# Known deficiencies of the service
* For the USA polygon zipcode service, Zipcode Tabulation Areas (ZCTA) are being used which [don't correspond to actual zipcode regions](http://web.archive.org/web/20050209030255/http://www.manifold.net/cases/zip_codes/zip_codes.html).
* Regarding the point geocoder service, being offered from GeoNames data: we've detected that the accuracy for a big section of zipcodes is not as good as intended, as GeoNames interpolates zipcode-populated place information. As an example, in the case of Madrid, Spain, all the zipcodes belonging to the city are geocoded in the centroid of the city itself.
  This issue can be spotted easily by comparing interesecting zipcode points:
  `SELECT the_geom, the_geom_webmercator, COUNT(*), adm0_a3 FROM postal_code_points GROUP BY the_geom, the_geom_webmercator, adm0_a3 HAVING COUNT(*) > 1 order by count(*)`

  In this case, we conclude that most affected countries are Portugal, Mexico, Spain, Netherlands, Czech Republic or Slovakia, meanwhile Brazil doesn't show intersecting values.

  The visual result of intersecting zipcodes is demonstrated in the following figure:
  ![Duplicates](https://camo.githubusercontent.com/1dbd4874830b0654b2fc2e11cd2a650d498f6bc9/68747470733a2f2f646c2e64726f70626f7875736572636f6e74656e742e636f6d2f752f323837393330382f53637265656e25323053686f74253230323031352d30362d3239253230617425323031322e35362e30332e706e67)

# Historic:
* [01/12/2015]:
  * Removed geocoder function. Check /extensions instead.
* [30/10/2015]:
  * Found bug #173 https://github.com/CartoDB/data-services/issues/173
* [19/10/2015]:
  * Updates readme with usage examples and setup scripts
* [08/10/2015]:
  * Adds response data types
* [15/07/2015]:
  * Adds basic tests for postal codes polygons
* [02/07/2015]:
  * Adds known deficiencies and coverage map
* [24/06/2015]:
  * Updated readme.md: added information about tables, function, indexes and the known issues section.
  * Review and [upload functions](https://github.com/CartoDB/data-services/pull/152)
