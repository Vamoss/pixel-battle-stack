#!/bin/sh

docker_cleanup()
{
    echo "Removing all docker objects"
    {
        docker kill $(docker ps -q)
        docker rm $(docker ps -a -q)
        docker rmi $(docker images -q -f dangling=true)
        docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
        docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
        docker rmi $(docker images -q)
        docker network rm $(docker network ls | grep "bridge" | awk '/ / { print $1 }')
    } &> /dev/null
    echo "Docker was cleaned!"
    echo
}

docker_cleanup

cd /home/ec2-user

case $DEPLOYMENT_GROUP_NAME in
    "RethinkDB-Prod")
        docker-compose -f docker-compose.db.prod.yml up --build --force-recreate -d rethinkdb
        ;;
    "App-Prod")
        cp /env/.env app/.env
        cp /env/ssl/* app/nginx
        docker-compose -f docker-compose.app.prod.yml up --build --force-recreate -d app
        ;;
esac
