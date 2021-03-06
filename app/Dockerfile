FROM alpine:3.8

LABEL maintainer="Cristian Mello <cristianc.mello@gmail.com>"

ARG APP_ENV=prod
ENV APP_ENV ${APP_ENV}

ARG NODE_ENV=prod
ENV NODE_ENV ${NODE_ENV}

ARG WORKDIR_SRC_DEFAULT=pixelbattle
ENV WORKDIR_SRC_DEFAULT ${WORKDIR_SRC_DEFAULT}

ARG APP_GIT_BRANCH=aws
ENV APP_GIT_BRANCH ${APP_GIT_BRANCH}

# Non-Root User
# Add a non-root user to prevent files being created with root permissions on host machine.
ARG PUID=1000
ARG PGID=1000

ENV PUID ${PUID}
ENV PGID ${PGID}

RUN addgroup -g ${PGID} workspace && \
    adduser -D -u ${PUID} -G workspace workspace

RUN set -ex && \
    apk upgrade && \
    apk --update --no-cache add \
    bash \
    openssh-client \
    nginx \
    curl \
    nodejs-npm \
    yarn \
    git \
    openssl \
    vim \
    nano

RUN yarn global add \
    express-generator \
    nodemon

# SSH RSA for Deploy
# Make ssh dir
# RUN mkdir -p /root/.ssh/

# Copy over private key, and set permissions
#ADD ops/build/shared-conf/ssh/id_rsa /root/.ssh/id_rsa
#ADD ops/build/shared-conf/ssh/id_rsa.pub /root/.ssh/id_rsa.pub

# Create known_hosts
#RUN touch /root/.ssh/known_hosts

# Add github key
#RUN ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts

# Default permission to .ssh folder
#RUN chmod 400 -R /root/.ssh/

# NGINX config
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out /etc/ssl/certs/nginx-selfsigned.crt \
  -subj "/C=BR/ST=Rio de Janeiro/L=Rio de Janeiro/O=PixelBattle/OU=IT/CN=_" && \
  openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

RUN mkdir -p /etc/nginx/snippets
COPY app/nginx/nginx.conf.${APP_ENV} /etc/nginx/nginx.conf
COPY app/nginx/self-signed.conf /etc/nginx/snippets/self-signed.conf
COPY app/nginx/ssl-params.conf /etc/nginx/snippets/ssl-params.conf

# HTTP errors
COPY app/nginx/errors /usr/share/nginx/html/errors

# Setup Entrypoint
COPY app/entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

WORKDIR /public/${WORKDIR_SRC_DEFAULT}

ENTRYPOINT /entrypoint.sh ${APP_ENV}
