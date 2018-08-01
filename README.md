# PixelBattle Stack

## Services and Components

* Service **app** (image `pixelbattle-app`):
  * Nginx (*as reverse proxy*): [http://localhost:8080](http://localhost:8080) (external);
    * Reverse proxy *listening* server on [http://localhost:3000](http://localhost:3000) (internal);

  * NodeJS 8.11.3 LTS + NPM + Yarn;

* Service **rethinkdb** (image `pixelbattle-rethinkdb`):
  * `rethinkdb-entrypoint-db.init.sh` for default init scripts;
  * Data folder in `/rethinkdb/data`;
  * Local and Ports:
    * **Client driver connections**:
      1. External: [http://localhost:28015](http://localhost:28015);
      2. Internal: [http://rethinkdb:28015](http://rethinkdb:28015);
    * **Administrative HTTP connections**:
      1. External: [http://localhost:4321](http://localhost:4321);
      2. Internal: [http://rethinkdb:8080](http://rethinkdb:8080);
    * **Intracluster connections**:
      1. Internal: [http://localhost:29015](http://localhost:29015);
      2. External: [http://rethinkdb:29015](http://rethinkdb:29015).

## Requirements

* **Docker Compose v1.21.2** or superior;
* **Docker v18.06.0-ce** or superior;
* **Bash v4.3** or superior.

## First clone the application repository

* The path is `src`. Folder name must be `pixelbattle`:

```
git clone git@github.com:cristiancmello/pixelbattle.git src/
```

## Local Development

### 'Dev' environment

* Start **app** and **rethinkdb** services:

```sh
APP_ENV=dev docker-compose up -d app rethinkdb
```

* Start all services:

```sh
APP_ENV=dev docker-compose up -d
```

* Stop and down network interface:

```sh
docker-compose down
```

* For more details, access [Docker Compose - Official Documentation](https://docs.docker.com/compose/).

## About `rethinkdb` service

When you start the database service, the `rethinkdb-entrypoint-db.init.sh` script will automatically create, if not exist:

* Database named **pixelbattle_db**;
* User:
  * **username**: `pixelbattle`
  * **password**: `pixelbattle`

## Environment variables

The `shared-conf/env.example.dev` file with environment variables can be used in the application to be hosted in `src/pixelbattle`.
