#!/bin/sh
#Start services
service php8.2-fpm start
nginx -g 'daemon off;'