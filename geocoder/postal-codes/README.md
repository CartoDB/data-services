### Postal Code Polygons

##### Parameters

| name           | type    | optional? |
| -------------- |:-------:| ---------:|
| postal_code    | text[]  | false     |
| country_code   | string  | true      |
| country_codes  | text[]  | true      |

##### Current coverage

United States, Canada, Australia

#### Example requests

```sql
SELECT (geocode_postalcode_polygons(Array['10013','11201','03782'])).*
```

```sql
SELECT (geocode_postalcode_polygons(Array['10013','11201','03782'], 'USA')).*
```

```sql
SELECT (geocode_postalcode_polygons(Array['10013','G9H','03782'], Array['USA', 'Canada', 'US'])).*
```

#### Links

[See it on the api](http://bit.ly/1c3NEu8)

[See plpgsql](Geocoder-for-Postal-Code-Polygons)

### Postal Code Points

##### Parameters

| name           | type    | optional? |
| -------------- |:-------:| ---------:|
| postal_code    | text[]  | false     |
| country_code   | string  | true      |
| country_codes  | text[]  | true      |

##### Current coverage

Global [see list](http://bl.ocks.org/andrewxhill/raw/8922596/)

#### Example requests

```sql
SELECT (geocode_postalcode_points(Array['10013','11201','03782'])).*
```

```sql
SELECT (geocode_postalcode_points(Array['10013','11201','03782'], 'USA')).*
```

```sql
SELECT (geocode_postalcode_points(Array['10013','G9H','03782'], Array['USA', 'Canada', 'US'])).*
```

#### Links

[See it on the api](https://geocoding.cartodb.com/api/v2/sql?q=SELECT%20(geocode_postalcode_points(Array[%2710013%27,%27G9H%27,%2703782%27],%20Array[%27USA%27,%20%27Canada%27,%20%27US%27])).*)

[See plpgsql](Geocoder-for-Postal-Code-Points)
