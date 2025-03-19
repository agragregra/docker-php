ARG PHP_VERSION=8.0

FROM php:${PHP_VERSION}-apache

ENV EXT="mysqli pdo_mysql zip gd"

RUN apt-get update && apt-get install -y \
    libzip-dev \
    libfreetype-dev \
    libjpeg-dev \
    libpng-dev \
    libwebp-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
  && docker-php-ext-install -j$(nproc) ${EXT} \
  && a2enmod rewrite \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["apache2-foreground"]
