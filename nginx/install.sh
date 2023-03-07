#!/bin/sh
if [ ! -f /var/.startup/.installed ]; then
    cd /app || exit

    echo "Replacing env vars in nginx config files for domains: ${DOMAINS}"
    sed -i "s|\[DOMAINS\]|$DOMAINS|g" /etc/nginx/conf.d/default.conf
    sed -i "s|\[PHP_INT_PORT\]|$PHP_INT_PORT|g" /etc/nginx/conf.d/default.conf
    sed -i "s|\[PHP_HOST\]|$PHP_HOST|g" /etc/nginx/conf.d/default.conf
    sed -i "s|\[HTTP_INT_PORT\]|$HTTP_INT_PORT|g" /etc/nginx/conf.d/default.conf
    sed -i "s|\[HTTPS_INT_PORT\]|$HTTPS_INT_PORT|g" /etc/nginx/conf.d/default.conf

    if [ ! -f /var/keyz/main-local.key ] && [ ! -f /var/keyz/main-local.crt ]; then
        sed -i "s|\[DOMAINS\]|$DOMAINS|g" /var/keyz/.ca.cnf
        openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /var/keyz/main-local.key -out /var/keyz/main-local.crt -config /var/.ca.cnf
    fi

    touch /var/.startup/.installed
fi
