FROM php:7.4-fpm

RUN apt-get update

RUN apt-get install -y wget

RUN wget https://sourceforge.net/projects/libjpeg-turbo/files/2.0.4/libjpeg-turbo-official_2.0.4_amd64.deb
RUN dpkg -i libjpeg-turbo-official_2.0.4_amd64.deb


# RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb
# RUN apt-get -f install ./wkhtmltox_0.12.6-1.focal_amd64.deb

RUN apt-get install -y dos2unix htop nano curl screen libsodium-dev libmcrypt-dev libzip-dev zlib1g-dev libpq-dev git libicu-dev libfreetype6-dev libwebp-dev libxml2-dev libpng-dev libjpeg-dev libonig-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install sockets \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-install zip xml \
    && docker-php-ext-install sodium

RUN apt-get install -y libfreetype6-dev
RUN docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype
RUN docker-php-ext-install gd
RUN docker-php-ext-enable gd

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && sync

RUN install-php-extensions tidy;
RUN install-php-extensions curl;
RUN install-php-extensions exif;


RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

ENV NODE_VERSION=16.11.1

ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

RUN npm install yarn -g

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
RUN "date"


WORKDIR /app

RUN mkdir /var/.run

RUN mkdir /var/.startup

COPY ./composer.sh /var/.run/composer.sh
RUN dos2unix /var/.run/composer.sh
RUN ["chmod", "+x", "/var/.run/composer.sh"]

COPY ./configs/.env /var/.startup/.env

COPY ./entrypoint.sh /var/.startup/entrypoint.sh
RUN dos2unix /var/.startup/entrypoint.sh
RUN ["chmod", "+x", "/var/.startup/entrypoint.sh"]

COPY ./install.sh /var/.startup/install.sh
RUN dos2unix /var/.startup/install.sh
RUN ["chmod", "+x", "/var/.startup/install.sh"]

COPY ./php.ini /usr/local/etc/php/php.ini

ENTRYPOINT ["sh", "/var/.startup/entrypoint.sh"]
