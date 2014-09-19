Available Services
===============

### Function

Can be used to lookup available services by country name. Example,

```sql
SELECT (admin0_available_services(Array['United States', 'ESP'])).*
```

The functions in sql/build_services_table.sql should be run after any postalcode update.