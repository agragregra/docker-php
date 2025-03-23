FROM php:8.2-apache

ENV EXT="mysqli pdo_mysql zip gd mbstring opcache intl"

RUN apt-get update && apt-get install -y \
    nano \
    rsync \
    unzip \
    openssh-client \
    libzip-dev \
    libonig-dev \
    libfreetype-dev \
    libjpeg-dev \
    libpng-dev \
    libwebp-dev \
    libicu-dev \
  && docker-php-ext-configure intl \
  && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
  && docker-php-ext-install -j$(nproc) ${EXT} \
  && a2enmod rewrite \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
  && php -r "unlink('composer-setup.php');" \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["apache2-foreground"]
