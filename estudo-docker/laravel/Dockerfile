FROM php:7.4-cli

WORKDIR /var/www

RUN apt-get update && \
    apt-get install -y libzip-dev && \
    docker-php-ext-install zip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');"

RUN php composer.phar create-project --prefer-dist laravel/laravel blog

ENTRYPOINT ["php", "blog/artisan", "serve"]
CMD [ "--host=0.0.0.0" ]
