Available Services
===============

# Function

Can be used to lookup available services by country name. Example,

```sql
SELECT (admin0_available_services(Array['United States', 'ESP'])).*
```

The functions in `sql/build_services_table.sql` should be run after any postalcode update.

# Tables
### available_services
#### Table structure
````
                                                                 Table "public.available_services"
        Column        |           Type           |                                Modifiers                                | Storage  | Stats target | Description 
----------------------+--------------------------+-------------------------------------------------------------------------+----------+--------------+-------------
 adm0_a3              | text                     |                                                                         | extended |              | 
 admin0               | boolean                  |                                                                         | plain    |              | 
 cartodb_id           | integer                  | not null default nextval('available_services_cartodb_id_seq'::regclass) | plain    |              | 
 created_at           | timestamp with time zone | not null default now()                                                  | plain    |              | 
 updated_at           | timestamp with time zone | not null default now()                                                  | plain    |              | 
 the_geom             | geometry(Geometry,4326)  |                                                                         | main     |              | 
 the_geom_webmercator | geometry(Geometry,3857)  |                                                                         | main     |              | 
 postal_code_points   | boolean                  |                                                                         | plain    |              | 
 postal_code_polygons | boolean                  |                                                                         | plain    |              | 

````


#### Current indexes
````
Indexes:
    "available_services_pkey" PRIMARY KEY, btree (cartodb_id)
    "available_services_cartodb_id_key" UNIQUE CONSTRAINT, btree (cartodb_id)
    "available_services_the_geom_idx" gist (the_geom)
    "available_services_the_geom_webmercator_idx" gist (the_geom_webmercator)
```

# Related functions
* [admin0_available_services](https://github.com/CartoDB/data-services/blob/master/geocoder/available-services/sql/services.sql)

````
 Schema |           Name            |      Result data type       | Argument data types |  Type  
--------+---------------------------+-----------------------------+---------------------+--------
 public | admin0_available_services | SETOF available_services_v1 | name text[]         | normal
````


# Known issues

# Historic
* [24/06/2015]:
  * Updated readme.md: Add table/function information and known issues section. 
  * Reviewed function `admin0_available_services` in `services.sql`
