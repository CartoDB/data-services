#!/bin/bash

TARGET_DIR_PATCHES=data_patches
BASE_URL=https://s3.amazonaws.com/data.cartodb.net/geocoding/dumps
VERSION=0.0.1

PATCHES_LIST="20160203_countries_bh_isocode.sql
20160622_countries_synonym_congo.sql
20171004_merge_corsica_and_france.sql
20180117_hsinchu_synonyms.sql"

mkdir -p $TARGET_DIR_PATCHES

for file in $PATCHES_LIST; do
    url="${BASE_URL}/${VERSION}/patches/$file"

    wget -c --directory-prefix=$TARGET_DIR_PATCHES $url
done
