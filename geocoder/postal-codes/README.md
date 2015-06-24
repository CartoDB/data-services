Postal code geocoder
===============

This section is divided in geocoding postal codes as points or as polygons. Each option has its own sources and its own functions which are  described below.
# Postal code geocoder: Polygons
## Function

By following the next steps a table is populated with zipcodes from Australia, Canada, USA and France (identified by iso3) related with their spatial location in terms of polygons.

## Creation steps

1. Import the four files attached in the section "Datasources".

2. Run sql/build_data_table.sql. Notice that table "postal_code_polygons" should exist in advance with columns: _the_geom_, _adm0_a3_ and _postal_code_.

## Data Sources

Australian polygons - http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/2033.0.55.0012011?OpenDocument
Download the KMZ for *Postal Area IRSD, SEIFA 2011*. Unzip and upload the kmz

Canadian polygons - http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2011-eng.cfm
Download ESRI Shp, Forward Sortation Areas, Digital Boundary 

USA polygons - http://www2.census.gov/geo/tiger/TIGER2013/ZCTA5/tl_2013_us_zcta510.zip

French polygons - http://www.data.gouv.fr/dataset/fond-de-carte-des-codes-postaux


## Preparation details

The names of the imported files are:

- doc for Australia table
- gfsa000a11a_e for Canada table
- tl_2013_us_zcta510 for USA table
- codes_postaux for France table

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

## Creation steps

1. Download the allCountries.zip file from [GeoNames](www.geonames.org). Import and rename the table as tmp_zipcode_points. You can follow the manual process explained below instead.


The columns that are loaded are the following ones:
field_1: corresponding to ISO2
field_10: corresponds to latitude
field_11: corresponds to longitude
field_2: corresponds to ZIP code

2. Georeference the table using field11 as longitude and field10 as latitude in order to construct the_geom.

3. Add column iso3 (text) and run sql/build_zipcode_points_table.sql.


**Alternative manual process**

Open the allCountries.txt file with Excel an add a new row on top. Delete columns C-I and L.

In the first row, add the following columns: iso2, zipcode, lat, long.

Import the file ignoring step 2.

## Data Sources

All countries points [GeoNames](www.geonames.org) - http://download.geonames.org/export/zip/allCountries.zip

## Preparation details

_The big size of the dataset may cause interruptions in the processing of the coordinates after uploading the file, manipulating the file before importing is a faster workaround._

# Known issues:
* The name of the countries added in a column are not being sanitized https://github.com/CartoDB/cartodb/issues/3392

# Historic:
* [24/06/2015]:
  * Updated readme.md: added information about tables, function, indexes and the known issues section. 
