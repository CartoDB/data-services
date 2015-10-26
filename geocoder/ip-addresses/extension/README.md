# CartoDB IP addresses geocoder extension
Postgres extension for the CartoDB IP addresses geocoder. It is meant to contain the functions and related objects needed to geocode by IP addresses. It is not meant to contain the actual data used to geocode them.

## Dependencies
This extension is thought to be used on top of CartoDB platform. Therefore a cartodb user is required to install the extension onto it.

The following is a non-comprehensive list of dependencies:

- Postgres 9.3+
- Postgis extension
- Schema triggers extension
- CartoDB extension

## Installation into the db cluster
This requires root privileges
```
sudo make all install
```

## Execute tests
```
PGUSER=postgres make installcheck
```

## Install onto a user's database
```
psql -U cartodb_dev_user_367c0edc-b2ad-4bab-ad43-3d58a6179a93_db cartodb_dev_user_367c0edc-b2ad-4bab-ad43-3d58a6179a93_db
```

and then:

```sql
CREATE EXTENSION cdb_geocoder_ipaddr;
```

The extension creation in the user's db does not require special privileges. It can be even created from the sql api.
