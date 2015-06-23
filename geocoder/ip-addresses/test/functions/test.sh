#!/bin/sh

# 
# SQL_API_ROUTE and API_KEY need to be
# conveniently filled for the requests
# to work.
#


SQL_API_ROUTE="****"
API_KEY="****"
OK=0
PARTIALOK=0

function set_failed() {
    OK=1
    PARTIALOK=1
}

function clear_partial_result() {
    PARTIALOK=0
}

function sql() {
    local QUERY
    if [[ $# -ge 1 ]]
    then
        QUERY="$1"
    fi

    echo $QUERY 
    RESULT=$(curl -s -X POST "https://$SQL_API_ROUTE/sql?api_key=$API_KEY&format=csv" --data-urlencode "q=$QUERY" |tail -n1 | tr -d '\r')

    if [[ "$2" == "should" ]]
    then
        if [[ "${RESULT}" != "$3" ]]
        then
            log_error "QUERY '${QUERY}' expected result '${3}' but got '${RESULT}'"
            set_failed
        fi
    fi
}

function log_info()
{
    echo
    echo
    echo
    _log "1;34m" "$1"
}

function log_error() {
    _log "1;31m" "$1"
}

function log_debug() {
    _log "1;32m" "> $1"
}

function log_warning() {
    _log "0;33m" "$1"
}

function _log() {
    echo -e "\033[$1$2\033[0m"
}

# '############################ HELPERS #############################'


function run_tests() {
    local FAILED_TESTS=()

    local TESTS
    if [[ $# -ge 1 ]]
    then
        TESTS="$@"
    else
        TESTS=`cat $0 | perl -n -e'/function (test.*)\(\)/ && print "$1\n"'`
    fi
    for t in ${TESTS}
    do
        echo "####################################################################"
        echo "#"
        echo "# Running: ${t}"
        echo "#"
        echo "####################################################################"
        clear_partial_result
        eval ${t}
        if [[ ${PARTIALOK} -ne 0 ]]
        then
            FAILED_TESTS+=(${t})
        fi
    done
    if [[ ${OK} -ne 0 ]]
    then
        echo
        log_error "The following tests are failing:"
        printf -- '\t%s\n' "${FAILED_TESTS[@]}"
    fi
}



#################################################### TESTS GO HERE ####################################################

function test_geocoding_functions_ip_addr() {
    # checks that the result is false and no geometry is returned for an invalid formatted/out of range IPv4
    sql "SELECT (geocode_ip(Array['1.0.16.280.1'])).success" should false
    sql "SELECT (geocode_ip(Array['1.0.16.280.1'])).geom is null" should true

    # checks that a valid IPv4 address returns a value and a success status
    sql "SELECT (geocode_ip(Array['8.2.16.0'])).success" should true
    sql "SELECT (geocode_ip(Array['8.2.16.0'])).geom is null" should false

    # check that the returned geometry is a point
    sql "SELECT ST_GeometryType((geocode_ip(Array['8.2.16.0'])).geom)" should ST_Point


}


#################################################### TESTS END HERE ####################################################



run_tests $@

exit ${OK}