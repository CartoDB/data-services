# Admin1 Geocoder

### Function

Accepts a list of terms. Terms are searched against the ```name_``` column in ```admin1_synonyms_qs```. The ```name_``` column is an automatically cleaned and populated column based on the raw values in ```name``` . The synonym table returns the proper global_id (based on rank values in table below). The global_id is then matched against the single row in the ```adm1``` table to return the correct polygon(s).

### Creation steps

1. Upload fresh Quattro Shapes admin1 data to `qs_adm1` table.
2. Upload fresh Quattro Shapes admin1 **region** data to `qs_adm1_region` table.
3. Upload fresh Natural Earth admin1 states provinces data to `ne_admin1_v3`
3. If fresh, add all sql/indexes.sql and sql/triggers.sql
4. Run the sql/build_data_table.sql script.
5. Run the sql/build_admin1_synonyms.sql script.
6. If needed, load or replace the function with sql/geocoder.sql


### Data Sources

(see the wiki page: [Geocoder Data Sources #admin1-states-provinces](https://github.com/CartoDB/data-services/wiki/Geocoder-Datasources#admin1-statesprovinces))

- Quattro Shapes admin1 and admin1 region polygons are being used for geometry. Users dislike natural earth's small admin1 units in countries like Spain, Italy and France so we have replaced these smaller units with their parent regions. 

- Natural Earth admin1 alternate name spellings will be used as synonyms when the Quattro Shapes `qs_source` = 'Natural Earth'.

## Admin1 Synonyms

The table contains the following columns to be populated:

1. **adm0_a3** : ISO code for the region. Used to get the unique geometry for the region in terms of the synonym.

2. **name**: Actually, the synonym you want to include for a specific region (identified ad adm0_a3).

3. **notes:** Extra information as the source of the data. Use: 'data source: X'.

4. **rank**: Rank of the synonym being matched to. 0 is highest.

5. **global_id** Unique identifier created in `build_data_table.sql`.

### Ranks

| rank number | origin data                 | origin column | description          |
|-------------|-----------------------------|---------------|----------------------|
| 0			  | Quattro Shapes				| qs_a1 | default name for qs_adm1 |
| 0				| Quattro Shapes			| qs_a1r | default name for qs_adm1_region |
| 1				| Quattro Shapes			| qs_a1_lc | admin code |
| 2 			| Natural Earth 			| name_alt | alternate spelling | 
| 3				| Natural Earth				| abbrev   | abbreviation |
| 4				| Natural Earth				| postal   | postal code  |
| 5 			| Natural Earth 			| gn_name  | formal english name  | 					

