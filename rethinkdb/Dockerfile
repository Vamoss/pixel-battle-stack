FROM cristiancmello/rethinkdb-supervisor:0.1.0

LABEL maintainer="Cristian Mello <cristianc.mello@gmail.com>"

COPY ./rethinkdb/rethinkdb-entrypoint-db.init.sh    /
COPY ./rethinkdb/scripts    /scripts
COPY ./rethinkdb/.env   /scripts