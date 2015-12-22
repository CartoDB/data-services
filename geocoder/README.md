CartoDB Internal Geocoder
====


# API Response Format

## Parameters

| Field  | Explanation                                 | Type   |
| ------ |:--------------------------------------------:| ------:|
| q      | Input query text                             | text   |
| success| Was it successfully geocoded?                | boolean|
| geom   | Resolved geometry, NULL if none              | wkb    |
| c      | Input country text if provided and variable  | text   |

* ```q``` will be searched on in lowercase but returned in input form
* ```c``` will always be returned in the form it was given, including empty string and NULL
* ```c``` will be resolved to an ISO code using a lookup dictionary
* ```c``` when NULL or empty will make the search for that entry fall back to countryless


## Existing Services

### Level 0 administrative regions (Countries)

##### Data type
Polygons

##### Parameters

| name      | type    | optional? |
| --------- |:-------:| ---------:|
| name      | text[]  | false     |

##### Current coverage

Global

#### Example requests

```sql
SELECT (geocode_admin0_polygons(Array['Spain', 'USA', ''])).*
```

#### Links

[See it on the api](http://geocoding.cartodb.com/api/v2/sql?q=SELECT%20(geocode_admin0_polygons(Array[%27Spain%27,%20%27USA%27,%20%27%27])).*)

[See plpgsql](https://github.com/CartoDB/data-services/blob/master/geocoder/admin0/sql/geocoder.sql)

### Level 1 administrative regions (States/Provinces)

##### Data type
Polygons

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

[See plpgsql](https://github.com/CartoDB/data-services/blob/master/geocoder/admin1/sql/geocoder.sql)

### Named Places

##### Data type
Points

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

[See plpgsql](https://github.com/CartoDB/data-services/blob/master/geocoder/namedplace/sql/geocode_namedplace.sql)

### IP Addresses

##### Data type
Points

##### Parameters

| name           | type    | optional? |
| -------------- |:-------:| ---------:|
| IP query array  | text[]  | false     |

##### Current coverage

Global

#### Example request

```sql
SELECT (geocode_ip(Array['1.0.16.0', '::ffff:1.0.16.0', 'not an IP'])).*
```

#### Links

[See it on the api](http://geocoding.cartodb.com/api/v2/sql?q=SELECT%20(geocode_ip(Array[%271.0.16.0%27,%20%27::ffff:1.0.16.0%27,%20%27not%20an%20IP%27])).*)

[See plpgsql](https://github.com/CartoDB/data-services/blob/master/geocoder/ip-addresses/sql/geocoder.sql)

### Postal Code Polygons

##### Parameters

| name           | type    | optional? |
| -------------- |:-------:| ---------:|
| postal_code    | text[]  | false     |
| country_code   | string  | true      |
| country_codes  | text[]  | true      |

##### Current coverage

United States, Canada, Australia, France

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

[See it on the api](http://geocoding.cartodb.com/api/v2/sql?q=SELECT%20(geocode_postalcode_points(Array[%2703204%27],Array[%27ESP%27])).*)

[See plpgsql](https://github.com/CartoDB/data-services/blob/master/geocoder/postal-codes/sql/geocoder.sql)

### Postal Code Points

##### Parameters

| name           | type    | optional? |
| -------------- |:-------:| ---------:|
| postal_code    | text[]  | false     |
| country_code   | string  | true      |
| country_codes  | text[]  | true      |

##### Current coverage

Global [see list](https://github.com/CartoDB/data-services/blob/master/geocoder/postal-codes/README.md#function-1)

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

[See plpgsql](https://github.com/CartoDB/data-services/blob/master/geocoder/postal-codes/sql/geocoder.sql)
