FROM php:8.2-fpm
RUN apt-get update \
 && apt-get install -y git zip unzip vim libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev libfontconfig1 libxrender1

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install gd bcmath pdo_mysql mysqli exif \
 && cd /usr/bin && curl -s http://getcomposer.org/installer | php \
 && ln -s /usr/bin/composer.phar /usr/bin/composer

ENV NODE_VERSION=16.16.0
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
 && . /root/.nvm/nvm.sh && nvm install ${NODE_VERSION} && nvm use v${NODE_VERSION} && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"