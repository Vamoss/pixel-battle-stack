FROM alpine:3.8

LABEL maintainer="Cristian Mello <cristianc.mello@gmail.com>"

ARG APP_ENV=dev
ENV APP_ENV ${APP_ENV}

ARG WORKDIR_SRC_DEFAULT=pixelbattle
ENV WORKDIR_SRC_DEFAULT ${WORKDIR_SRC_DEFAULT}

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
    vim \
    nano \
    bash \
    openssh-client \
    nginx \
    curl \
    nodejs-npm \
    yarn \
    git

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
COPY api/nginx/nginx.conf /etc/nginx/nginx.conf

# HTTP errors
COPY api/nginx/errors /usr/share/nginx/html/errors

WORKDIR /public/${WORKDIR_SRC_DEFAULT}

CMD ["nginx", "-g", "pid /tmp/nginx.pid; daemon off;"]