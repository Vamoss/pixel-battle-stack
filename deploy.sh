#!/bin/sh

cd /home/ec2-user

case $DEPLOYMENT_GROUP_NAME in
    "RethinkDB-Prod")
        APP_ENV=prod docker-compose -f docker-compose.prod.yml up -d rethinkdb
        ;;
esac
