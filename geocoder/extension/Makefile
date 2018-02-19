# Makefile to generate the extension out of separate sql source files.
# Once a version is released, it is not meant to be changed. E.g: once version 0.0.1 is out, it SHALL NOT be changed.
EXTENSION = cdb_geocoder
EXTVERSION = $(shell grep default_version $(EXTENSION).control | sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

DATA = $(EXTENSION)--$(EXTVERSION).sql

REGRESS = $(notdir $(basename $(sort $(wildcard test/sql/*test.sql))))
TEST_DIR = test/
REGRESS_OPTS = --inputdir='$(TEST_DIR)' --outputdir='$(TEST_DIR)' --user='postgres'

# postgres build stuff
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)


SOURCES_DATA = $(wildcard sql/*.sql)

$(DATA): $(SOURCES_DATA)
	rm -f $(EXTENSION)--*.sql
	cat $(SOURCES_DATA) >> $@

all: $(DATA)

# Only meant for development time, do not use once a version is released
devclean:
	rm -f $(DATA)
