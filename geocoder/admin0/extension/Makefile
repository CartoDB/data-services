EXTENSION = cdb_geocoder_admin0
DATA = \
  cdb_geocoder_admin0--0.0.1.sql \
  cdb_geocoder_admin0--0.0.1--0.0.2.sql \
  cdb_geocoder_admin0--0.0.2--0.0.1.sql
REGRESS = cdb_geocoder_admin0_test

# postgres build stuff
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
