#!/bin/sh
source data/test.sh
source functions/test.sh

# 
# The following script has two use modes:
# 
# API
# ====================================
# SQL_API_ROUTE and API_KEY need to be
# conveniently filled for the requests
# to work.
# Example: bash run.sh api sql_api_route api_key test_type
#
# SQL
# ====================================
# It is expected that you run this script
# as a PostgreSQL superuser, for example:
#
# bash run.sh db database role test_type
#
# test_type defines the kind of tests to run: data or functions

MODE=''
TEST_TYPE=''

# DB settings
DATABASE=''
ROLE=''
CMD='echo psql'
CMD=psql

# SQL API settings
SQL_API_ROUTE=''
API_KEY=''

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
    local QUERY="$1"
    if [[ $MODE = "api" ]]
    then
    # SQL API mode
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
   	# Database mode
    elif [[ $MODE = "db" ]]
    then
    	if [ -n "${ROLE}" ]; then
      		log_debug "Executing query '${QUERY}' as ${ROLE}"
      		RESULT=`${CMD} -U "${ROLE}" ${DATABASE} -c "${QUERY}" -A -t`
    	else
      		log_debug "Executing query '${QUERY}'"
      		RESULT=`${CMD} ${DATABASE} -c "${QUERY}" -A -t`
    	fi
    	CODERESULT=$?

    	echo ${RESULT}
    	echo

    	if [[ ${CODERESULT} -ne 0 ]]
    	then
      		echo -n "FAILED TO EXECUTE QUERY: "
      		log_warning "${QUERY}"
      		if [[ "$2" != "fails" ]]
      		then
        		log_error "${QUERY}"
         		set_failed
       		fi
    	else
        	if [[ "$2" == "fails" ]]
        	then
          	  log_error "QUERY: '${QUERY}' was expected to fail and it did not fail"
          	  set_failed
       		 fi
    	fi

    	if [[ "$2" == "should" ]]
    	then
      		if [[ "${RESULT}" != "$3" ]]
      		then
            	log_error "QUERY '${QUERY}' expected result '${3}' but got '${RESULT}'"
            	set_failed
        	fi
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
    
    MODE="$1"
    if [[ $MODE = "api" ]]
    then
    	SQL_API_ROUTE="$2"
    	API_KEY="$3"
    	TEST_TYPE="$4"
    fi
    if [[ $MODE = "db" ]]
    then
    	DATABASE="$2"
    	ROLE="$3"
    	TEST_TYPE="$4"
    fi

    if [[ $# -ge 4 ]]
    then
    	if [[ $TEST_TYPE = "data" ]]
    	then
        	TESTS=`cat data/test.sh| perl -n -e'/function (test.*)\(\)/ && print "$1\n"'`
        elif [[ $TEST_TYPE = "functions" ]]
        then
        	TESTS=`cat functions/test.sh| perl -n -e'/function (test.*)\(\)/ && print "$1\n"'`
        fi
    else
        TESTS="$@"
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
    else
    	echo
    	log_info "Test finished"
    fi
}


run_tests $@

exit ${OK}
