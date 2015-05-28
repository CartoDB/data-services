### IP Addresses - Points

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

See plpgsql in geocoder.sql
