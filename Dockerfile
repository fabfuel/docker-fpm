FROM php:5.6-fpm

MAINTAINER Fabian Fuelling <docker@fabfuel.de>

# Install modules
RUN apt-get update; apt-get install -y php5-dev git libpq-dev libmemcached-dev libicu-dev && apt-get clean
RUN docker-php-ext-install pdo_mysql pdo_pgsql intl pgsql
RUN pecl install -f apcu mongo redis memcached xdebug

# checkout, compile and install Phalcon extension
RUN cd ~; git clone https://github.com/phalcon/cphalcon -b master --single-branch; cd ~/cphalcon/build; ./install; rm -rf ~/cphalcon

COPY www/ /var/www
COPY config/php.ini /usr/local/etc/php/conf.d/custom.ini

WORKDIR /var/www
EXPOSE 9000

CMD ["php-fpm"]
