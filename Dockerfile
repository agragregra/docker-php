FROM php:8.2-apache
ENV EXT="mysqli pdo_mysql"
RUN bash -c "docker-php-ext-install ${EXT} && a2enmod rewrite"
CMD ["apache2-foreground"]
