# CartoDB geocoder extension
Postgres extension for the CartoDB geocoder. It is meant to contain the functions and related objects needed to provide a geocoding service for administrative areas of level 0, administrative areas of level 1, postal codes, IP addresses and city names. It is not meant to contain the actual data used to geocode them.

## Dependencies
This extension is thought to be used on top of CartoDB platform. Therefore **a cartodb user is required** to install the extension onto it.

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

## Build, install & test
One-liner:
```
sudo PGUSER=postgres make all install installcheck
```

## Install onto a cartodb user's database

Remember that **is mandatory to install into a cartodb user's database**

```
psql -U development_cartodb_user_fe3b850a-01c0-48f9-8a26-a82f09e9b53f cartodb_dev_user_fe3b850a-01c0-48f9-8a26-a82f09e9b53f_db
```

and then:

```sql
CREATE EXTENSION cdb_geocoder;
```

The extension creation in the user's db does not require special privileges. It can be even created from the sql api.
