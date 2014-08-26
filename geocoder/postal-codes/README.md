Postal code geocoder (polygons)
===============

### Function

### Creation steps

### Data Sources

Australian polygons - http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/2033.0.55.0012011?OpenDocument
Download the KMZ for *Postal Area IRSD, SEIFA 2011*. Unzip and upload the kmz

Canadian polygons - http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2011-eng.cfm
Download ESRI Shp, Forward Sortation Areas, Digital Boundary 

USA polygons - http://www2.census.gov/geo/tiger/TIGER2013/ZCTA5/tl_2013_us_zcta510.zip

French polygons - http://www.data.gouv.fr/dataset/fond-de-carte-des-codes-postaux

All countries points [GeoNames](www.geonames.org) - http://download.geonames.org/export/zip/allCountries.zip


### Preparation details

# Postal code geocoder (points)

Download the allCountries.zip file from [GeoNames](www.geonames.org). Import and rename the table as tmp_zipcode_points. You can follow the manual process explained below instead.

  This dataset includes data for the following countries:
 
  ````
  CH, ES, GU, ZA, MX, SJ, NL, RU, AX, TH, AR, MY, RE, LK, GB, IS, GL, JE, DK, IN,
  SI, GP, MQ, BR, SM, BG, NZ, MP, CZ, DO, MD, PK, TR, VI, BD, GG, LT, PM, MC, US,
  IT, LU, SK, LI, PR, IM, NO, PT, PL, FI, JP, CA, DE, HU, PH, SE, VA, YT, MK, FR,
  MH, RO, FO, GF, AD, HR, DZ, GT, AU, AS, BE, AT
  ````

  The columns that are loaded are the following ones:

  - field_1: corresponding to ISO2
  - field_10: corresponds to latitude
  - field_11: corresponds to longitude
  - field_2: corresponds to ZIP code

1. Georeference the table using field11 as longitude and field10 as latitude in order to construct the_geom.

2. Add column iso3 (text) and run sql/build_zipcode_points_table.sql.


**Alternative manual process**

1. Open the allCountries.txt file with Excel an add a new row on top. 

2. Delete columns C-I and L.

3. In the first row, add the following columns: iso2, zipcode, lat, long.

4. Import the file ignoring step 1.

_The big size of the dataset may cause interruptions in the processing of the coordinates after uploading the file, manipulating the file before importing is a faster workaround._


