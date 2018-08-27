#!/bin/sh

cd /home/ec2-user

case $DEPLOYMENT_GROUP_NAME in
    "RethinkDB-Prod")
        APP_ENV=prod docker-compose -f docker-compose.db.prod.yml --build --force-recreate up -d rethinkdb
        ;;
    "App-Prod")
        APP_ENV=prod docker-compose -f docker-compose.app.prod.yml --build --force-recreate up -d app
        ;;
esac
