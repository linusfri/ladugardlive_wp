#!/bin/sh
chown -R www-data:www-data /app
service php8.2-fpm start
nginx -g 'daemon off;'