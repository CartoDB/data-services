# Makefile to generate the extension out of separate sql source files.
# Once a version is released, it is not meant to be changed. E.g: once version 0.0.1 is out, it SHALL NOT be changed.
EXTENSION = cdb_geocoder
EXTVERSION = $(shell grep default_version $(EXTENSION).control | sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

NEW_EXTENSION_ARTIFACT = $(EXTENSION)--$(EXTVERSION).sql
DATA = $(NEW_EXTENSION_ARTIFACT)
AWK = awk

REGRESS = $(notdir $(basename $(sort $(wildcard test/sql/*test.sql))))
REGRESS_EXPEC = $(notdir $(basename $(sort $(wildcard test/expected/*test.out))))
TEST_DIR = test_out
REGRESS_OPTS = --inputdir='$(TEST_DIR)' --outputdir='$(TEST_DIR)' --user='postgres'

# postgres build stuff
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

# PG12 compatibility
PG_VERSION := $(shell $(PG_CONFIG) --version | $(AWK) '{split($$2,a,"."); print a[1]}')
PG_12_GE := $(shell [ $(PG_VERSION) -ge 12 ] && echo true)
PLPYTHONU := plpythonu
ifeq ($(PG_12_GE), true)
PLPYTHONU := plpython3u
endif

SOURCES_DATA = $(wildcard sql/*.sql)

$(NEW_EXTENSION_ARTIFACT): $(SOURCES_DATA)
	rm -f $@
	cat $(SOURCES_DATA) | \
	sed -e 's/@@plpythonu@@/$(PLPYTHONU)/g' \
	>> $@

# Replacing variables defined within test files
prepare_tests:
	mkdir -p $(TEST_DIR)
	mkdir -p $(TEST_DIR)/expected
	mkdir -p $(TEST_DIR)/sql
	for f in $(REGRESS); do \
		cat test/sql/$${f}.sql | \
		sed -e 's/@@plpythonu@@/$(PLPYTHONU)/g' \
		> $(TEST_DIR)/sql/$${f}.sql; \
	done
	for f in $(REGRESS_EXPEC); do \
		cat test/expected/$${f}.out | \
		sed -e 's/@@plpythonu@@/$(PLPYTHONU)/g' \
		> $(TEST_DIR)/expected/$${f}.out; \
	done

.PHONY: all
all: prepare_tests $(DATA)

# Only meant for development time, do not use once a version is released
.PHONY: devclean
devclean:
	rm -f $(DATA)
	rm -rf $(TEST_DIR)
