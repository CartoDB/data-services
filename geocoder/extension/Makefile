# Makefile to generate the extension out of separate sql source files.
# Once a version is released, it is not meant to be changed. E.g: once version 0.0.1 is out, it SHALL NOT be changed.
EXTENSION = cdb_geocoder
EXTVERSION = $(shell grep default_version $(EXTENSION).control | sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

NEW_EXTENSION_ARTIFACT = $(EXTENSION)--$(EXTVERSION).sql
DATA = $(NEW_EXTENSION_ARTIFACT)

REGRESS = $(notdir $(basename $(sort $(wildcard test/sql/*test.sql))))
TEST_DIR = test/
REGRESS_OPTS = --inputdir='$(TEST_DIR)' --outputdir='$(TEST_DIR)' --user='postgres'

# postgres build stuff
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

SOURCES_DATA = $(wildcard sql/*.sql)

$(NEW_EXTENSION_ARTIFACT): $(SOURCES_DATA)
	rm -f $@
	cat $(SOURCES_DATA) >> $@

.PHONY: all
all: $(DATA)

# Only meant for development time, do not use once a version is released
.PHONY: devclean
devclean:
	rm -f $(DATA)
