#!/bin/bash

function usage() {
  cat <<EOF
Usage:
  $(basename $0) DBUSER DBNAME *.sql
E.g:
  $(basename $0) development_cartodb_user_87ddf981-25c7-4538-9910-0eb4342f2483 cartodb_dev_user_87ddf981-25c7-4538-9910-0eb4342f2483_db patches/*.sql
EOF
}


if [ "$#" -lt "3" ]; then
    usage
    exit 1
fi

DBUSER=$1
DBNAME=$2
shift; shift;
DUMP_FILES="$@"

echo
echo "About to import the following files: ${DUMP_FILES}"
for i in $DUMP_FILES; do
    echo
    echo "Importing ${i}..."
    psql \
        --username=${DBUSER} \
        --dbname=${DBNAME} \
        --set=ON_ERROR_STOP=on \
        --single-transaction \
        --file=${i} || exit 1
    echo "Done with ${i}."
    echo
done

echo
echo "** Everything OK **"