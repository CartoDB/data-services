# Makefile to generate the extension out of separate sql source files.
# Once a version is released, it is not meant to be changed. E.g: once version 0.0.1 is out, it SHALL NOT be changed.
EXTENSION = cdb_geocoder
EXTVERSION = $(shell grep default_version $(EXTENSION).control | sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

DATA = $(EXTENSION)--$(EXTVERSION).sql
REGRESS = \
  00_install_test \
  cdb_geocoder_admin0_test \
  cdb_geocoder_admin1_test

# postgres build stuff
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)


SOURCES_DATA = $(wildcard sql/$(EXTVERSION)/*.sql)

$(DATA): $(SOURCES_DATA)
	rm -f $@
	cat $(SOURCES_DATA) >> $@

all: $(DATA)

# Only meant for development time, do not use once a version is released
devclean:
	rm -f $(DATA)
