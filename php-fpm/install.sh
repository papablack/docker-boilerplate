#!/bin/sh
if [ ! -f /var/.startup/.installed ]; then
    cd /app || exit

    sh /var/.run/composer.sh    

    php ./init --env=Development --overwrite=All --delete=All

    yarn

    if [ ! -f /app/.env ]; then
        cp /var/.startup/.env /app/.env

        sed -i "s|\[MYSQL_DB\]|$MYSQL_DB|g" /app/.env
        sed -i "s|\[MYSQL_HOST\]|$MYSQL_HOST|g" /app/.env
        sed -i "s|\[MYSQL_INT_PORT\]|$MYSQL_INT_PORT|g" /app/.env
        sed -i "s|\[MYSQL_ROOT_PASSWORD\]|$MYSQL_ROOT_PASS|g" /app/.env

        sed -i "s|\[MAILER_LOGIN\]|$MAILER_LOGIN|g" /app/.env
        sed -i "s|\[MAILER_PASS\]|$MAILER_PASS|g" /app/.env
        sed -i "s|\[MAILER_HOST\]|$MAILER_HOST|g" /app/.env
        sed -i "s|\[MAILER_PORT\]|$MAILER_PORT|g" /app/.env
        sed -i "s|\[DOMAINS\]|$DOMAINS|g" /app/.env
    fi

    php composer.phar install --no-interaction

    rm /var/.run/composer.sh

    touch /var/.startup/.installed
fi
