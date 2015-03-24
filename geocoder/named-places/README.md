### Named Places Points

##### Parameters

| name           | type    | optional? |
| -------------- |:-------:| ---------:|
| named_place    | text[]  | false     |
| country_code   | string  | true      |
| country_codes  | text[]  | true      |

##### Current coverage

Global

#### Example requests

```sql
SELECT (geocode_namedplace(Array['Madrid', 'New York City', 'sunapee'])).*
```

```sql
SELECT (geocode_namedplace(Array['sunapee', 'sunapeeee', 'New York City'], 'USA')).*
```

```sql
SELECT (geocode_namedplace(Array['sunapee', 'sunapeeee', 'New York City', 'Madrid'], Array['', 'US', 'United States', NULL])).*
```

```sql
SELECT (geocode_namedplace(
    Array['Portland', 'Portland', 'New York City'], 
    Array['Maine',    'Oregon',    NULL],
    'USA')).*
```

```sql
SELECT (geocode_namedplace(
    Array['Portland', 'Portland', 'New York City'], 
    Array['Maine','Oregon', null], 
    NULL)).*
```

#### Links

[See it on the api](http://geocoding.cartodb.com/api/v2/sql?q=SELECT%20(geocode_namedplace(Array[%27sunapee%27,%20%27sunapeeee%27,%20%27New%20York%20City%27,%20%27Madrid%27],%20Array[%27%27,%20%27US%27,%20%27United%20States%27,%20NULL])).*)

See plpgsql in geocoder.sql
