EXTENSION = cdb_geocoder
EXTVERSION = $(shell grep default_version $(EXTENSION).control | sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

DATA = cdb_geocoder--0.0.1.sql
REGRESS = cdb_geocoder_admin0_test

# postgres build stuff
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)


SOURCES_0_0_1 = $(wildcard sql/0.0.1/*.sql)

cdb_geocoder--0.0.1.sql: $(SOURCES_0_0_1)
	rm -f $@
	cat $(SOURCES_0_0_1) >> $@

all: $(DATA)
