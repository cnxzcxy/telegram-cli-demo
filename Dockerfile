FROM php:5.6.40-cli-alpine

ARG TG_VERSION=6547c0b

LABEL maintainer="cnxzcxy <cnxzcxy@gmail.com>"
LABEL version=1.3.1

WORKDIR /usr/src/build

RUN apk add --no-cache \
        jansson-dev \
        libconfig-dev \
        libevent-dev \
        lua-dev \
        openssl-dev \
        readline-dev \
    &&  apk add --no-cache --virtual .build-deps \
        build-base \
        curl \
        git \
        zlib-dev \
    && git clone https://github.com/vysheng/tg \
    && cd tg \
    && git submodule update --init --recursive --force \
    && ./configure \
    && make \
    && apk del .build-deps \
    && mv /usr/src/build/tg/bin/telegram-cli /usr/bin/telegram-cli \
    && mkdir /etc/telegram-cli \
    && mv server.pub /etc/telegram-cli/server.pub \
    && rm -rf /usr/src/build \
    && addgroup -g 1000 telegram \
    && adduser -u 1000 -G telegram -s /bin/sh -D telegram

WORKDIR /

CMD ["telegram-cli --json -P 3345"]
