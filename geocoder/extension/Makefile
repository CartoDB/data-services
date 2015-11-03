EXTENSION = cdb_geocoder
EXTVERSION = $(shell grep default_version $(EXTENSION).control | sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

DATA = $(EXTENSION)--$(EXTVERSION).sql
REGRESS = cdb_geocoder_admin0_test

# postgres build stuff
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)


SOURCES_DATA = $(wildcard sql/$(EXTVERSION)/*.sql)

$(DATA): $(SOURCES_DATA)
	rm -f $@
	cat $(SOURCES_DATA) >> $@

all: $(DATA)
