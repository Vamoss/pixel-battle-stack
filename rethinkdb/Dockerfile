FROM rethinkdb:2.3

LABEL maintainer="Cristian Mello <cristianc.mello@gmail.com>"

RUN apt-get update && \
    apt-get install -y \
    curl

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y \
    nodejs

COPY ./rethinkdb/entrypoint.sh /

ENTRYPOINT /entrypoint.sh