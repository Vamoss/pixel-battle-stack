#!/bin/sh

# Get env vars
export $(egrep -v '^#' /.env | xargs)

db_healthcheck()
{
    set -e

    host="$1"
    port="$2"
    shift

    until nc -vz $host $port; do
      >&2 echo "Database is unavailable - sleeping"
      sleep 1
    done

    >&2 echo "Database is up - executing command"
    #node /scripts/createDb.js &
}

db_healthcheck ${DB_HOST} ${DB_PORT} &
