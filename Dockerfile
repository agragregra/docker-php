FROM php:8.0-apache

ENV EXT="mysqli pdo_mysql zip"

RUN apt-get update && apt-get install -y \
    libzip-dev \
  && docker-php-ext-install -j$(nproc) ${EXT} \
  && a2enmod rewrite

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["apache2-foreground"]
