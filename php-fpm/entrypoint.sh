#!/bin/sh

sh /var/.startup/install.sh
cd /app || exit
chmod -R 777 .
exec php-fpm &
while :; do sleep 10; done
