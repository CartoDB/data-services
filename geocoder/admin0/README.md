Admin0 Geocoder
===============

### Function

Accepts a list of terms. Terms are searched against the ```name_``` column in ```admin0_synonyms```. The ```name_``` column is an automatically cleaned and populated column based on the raw values in ```name_``` . The synonym table returns the proper ISO code (based on rank values in table below). The iso code is then matched against the single row in ```ne_admin0_v3``` to return the polygon.

### Creation steps

1. Upload fresh NaturalEarth data to ```ne_admin0_v3```. 
2. Delete all rows in the ```admin0_synonyms``` table. 
3. Ensure that all [indexes and triggers](https://github.com/CartoDB/data-services/wiki/Indexes-and-triggers) exist on these two tables.
4. Upload the data/wikipedia_countries_native_names.csv table if it doesn't already exist
5. Run the sql/subdivide_polygons.sql 
6. Run the sql/build_synonym_table.sql
7. If needed, load or replace the function with sql/geocoder.sql

### Data Sources

(see the wiki page: [Geocoder Data Sources #admin0-countries](https://github.com/CartoDB/data-services/wiki/Geocoder-Datasources#admin0-countries))

- natural earth data: ne_10m_admin_0_countries (version 3.0) which is currently stored in Geocoding.CartoDB as ne_admin0_v3

- native language spellings were gathered from http://en.wikipedia.org/wiki/List_of_countries_and_dependencies_and_their_capitals_in_native_languages and stored in data/wikipedia_countries_native_names.csv

### Preparation details

Users dislike the NaturalEarth aggregation of French regions into the mainland France polygon. We have done a minimal amount of subdivision. This can be done by executing,

sql/subdivide_polygons.sql 

## Admin0_synonyms

Documentation for the creation of the geocoder synonym tables.

For use with the admin0_geocoder.


### Ranks

| rank number | origin data                 | origin column | description          |
|-------------|-----------------------------|---------------|----------------------|
| 0           | natural earth 10m countries | name          | literal name     |
| 1           | natural earth 10m countries | name_alt      | alternate name       |
| 2           | wiki country navive names   | country_endonym |   local variation     |
| 3           | natural earth 10m countries | adm0_a3       | 3 digit country code |
| 4           | natural earth 10m countries | abbrev        | abbreviation         |
| 5           | natural earth 10m countries | formal_en     | formal english       |
| 6           | natural earth 10m countries | brk_name      | ?                    |
| 7           | natural earth 10m countries | formal_fr     | formal french        |

__notes:__ 

- The column `adm0_a3` will be used as a unique identifier.
- The ranks are somewhat arbitrarily organized and should be modified later based on our users use of the geocoder (will users more commonly geocode an adm0_a3 or abbreviation?) 
- I also forgot to assign a `rank` of `2` to a synonym.