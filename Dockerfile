# Use the official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ARG PHP_VERSION=8.2

# Update the package repository and install necessary packages
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-xmlrpc \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-cli \
    imagemagick \
    curl \ 
    gnupg2 \
    ca-certificates \
    lsb-release \
    ubuntu-keyring \ 
    nginx \
    nano \
    gosu

RUN rm /etc/nginx/sites-available/default && rm /etc/nginx/sites-enabled/default && rm /etc/php/8.2/fpm/php.ini

WORKDIR /

COPY ./nginx/ladugardlive.conf /etc/nginx/conf.d/ladugardlive.conf
COPY ./nginx/php-fpm-pool.conf /etc/php/8.2/fpm/pool.d/
COPY ./config/php.ini /etc/php/8.2/fpm/php.ini
COPY ./entrypoint.sh /entrypoint.sh

EXPOSE 80

# Start Nginx
RUN chmod +x entrypoint.sh /
ENTRYPOINT ["./entrypoint.sh"]