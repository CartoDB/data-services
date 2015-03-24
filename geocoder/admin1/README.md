# Admin1 (States/Provinces) Geocoder

##### Parameters

| name      | type    | optional? |
| --------- |:-------:| ---------:|
| name      | text[]  | false     |
| country   | text[]  | true      |
| countries | text[]  | true      |

##### Current coverage

Global

#### Example requests

```sql
SELECT (geocode_admin1_polygons(Array['TX','Cuidad Real', 'sevilla'])).*
```

```sql
SELECT (geocode_admin1_polygons(Array['NH', 'Vermont'], 'United States')).*
```

```sql
SELECT (geocode_admin1_polygons(Array['az', 'az'], Array['Ecuador', 'USA'])).*
```

#### Links

[See it on the api](http://geocoding.cartodb.com/api/v2/sql?q=SELECT%20(geocode_admin1_polygons(Array[%27az%27,%20%27az%27],%20Array[%27Ecuador%27,%20%27USA%27])).*)

See plpgsql in geocoder.sql
