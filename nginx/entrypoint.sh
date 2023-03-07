#!/bin/sh

sh /var/.startup/install.sh

chmod -R 777 /app/public

service nginx start

while :; do sleep 10; done
