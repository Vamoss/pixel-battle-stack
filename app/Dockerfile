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
    git

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
COPY app/nginx/nginx.conf.${APP_ENV} /etc/nginx/nginx.conf

# HTTP errors
COPY app/nginx/errors /usr/share/nginx/html/errors

COPY ./app/entrypoint.sh /

# Prepare PixelBattle app
RUN if [ ${APP_ENV} = prod ]; then \
    mkdir -p /public && \
    cd /public && \
    git clone -b ${APP_GIT_BRANCH} --progress --verbose https://github.com/Vamoss/pixelbattle.git && \
    yarn run build \
;fi

WORKDIR /public/${WORKDIR_SRC_DEFAULT}

ENTRYPOINT /entrypoint.sh ${APP_ENV}
