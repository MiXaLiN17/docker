FROM php:8.0.13-apache

# Update
RUN apt-get -y update --fix-missing && \
    apt-get upgrade -y && \
    apt-get --no-install-recommends install -y apt-utils && \
    rm -rf /var/lib/apt/lists/*


# Install useful tools and install important libaries
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install nano wget dialog libsqlite3-dev libsqlite3-0 && \
    apt-get -y --no-install-recommends install default-mysql-client zlib1g-dev libzip-dev libicu-dev libxml2-dev && \
    apt-get -y --no-install-recommends install --fix-missing apt-utils build-essential curl && \
    apt-get -y --no-install-recommends install --fix-missing libcurl3-openssl-dev zip openssl && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# Other PHP8 Extensions
RUN docker-php-ext-install opcache && \
    docker-php-ext-install zip && \
    docker-php-ext-install mysqli && \
    docker-php-ext-install -j$(nproc) intl

# Install xdebug
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

# Install Freetype
RUN apt-get -y update && \
    apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libxpm-dev libwebp-dev libpng-dev && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure gd --with-webp=/usr/include/ --with-jpeg=/usr/include/ --with-freetype=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd


# Enable apache modules
RUN a2enmod rewrite headers

ADD php.ini $PHP_INI_DIR/php.ini
ADD xdebug.ini $PHP_INI_DIR/conf.d/xdebug.ini

RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data
# Cleanup
RUN rm -rf /usr/src/*

WORKDIR /var/www/html
# Сообщаем, какие порты контейнера слушать
EXPOSE 80