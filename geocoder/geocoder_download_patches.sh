#!/bin/bash

TARGET_DIR_PATCHES=data_patches
BASE_URL=https://s3.amazonaws.com/data.cartodb.net/geocoding/dumps
VERSION=0.0.1

PATCHES_LIST="20160203_countries_bh_isocode.sql
20160622_countries_synonym_congo.sql
20171004_merge_corsica_and_france.sql
20180117_hsinchu_synonyms.sql
20180306_add_ssd_rows_for_south_sudan.sql
20181011_add_synonyms_for_swaziland.sql
20190111_france_regions_typos.sql
20210118_add_renamed_country_north_macedonia.sql
20220325_france_region_haut-rhin_typo.sql"

mkdir -p $TARGET_DIR_PATCHES

for file in $PATCHES_LIST; do
    url="${BASE_URL}/${VERSION}/patches/$file"

    wget -c --directory-prefix=$TARGET_DIR_PATCHES $url
done
