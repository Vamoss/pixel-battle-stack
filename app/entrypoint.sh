#!/bin/bash

args=($*)
APP_ENV=${args[0]}

cd /public/pixelbattle

case $APP_ENV in
    "dev")
        yarn dev-start &
        ;;
    "prod")
        yarn start &
        ;;
esac

nginx -g "pid /tmp/nginx.pid; daemon off;"