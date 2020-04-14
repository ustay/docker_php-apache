FROM php:apache

#
RUN apt-get update

# PHP Core extension: gd
RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        && docker-php-ext-configure gd --with-freetype --with-jpeg \
        && docker-php-ext-install -j$(nproc) gd

# PHP Core extension: pdo_mysql
RUN docker-php-ext-install pdo_mysql

# PHP Core extension: mysqli
RUN docker-php-ext-install mysqli

# PHP Core extension: bzip2
RUN apt-get install -y libbz2-dev \
        && docker-php-ext-install bz2

# PHP Core extension: zip
RUN apt-get install -y libzip-dev \
        && docker-php-ext-install zip

# PECL extension: apcu
RUN pecl install apcu \
        && docker-php-ext-enable apcu

# PECL extension: mcrypt
RUN apt-get install -y \
        libmcrypt4 \
        libmcrypt-dev \
        && pecl install mcrypt-1.0.2 \
        && docker-php-ext-enable mcrypt

# LDAP
RUN apt-get install -y libldap2-dev \
        && docker-php-ext-install ldap

# Zend extension: opcache
RUN docker-php-ext-enable opcache

# exif
RUN docker-php-ext-install exif

# imagemagick
RUN apt-get install -y libmagickwand-dev \
        && pecl install imagick \
        && docker-php-ext-enable imagick

#
RUN apt-get autoremove
RUN apt-get clean

# enable apache2 module
RUN a2enmod rewrite

