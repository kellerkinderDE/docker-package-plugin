FROM php:7.3-alpine

COPY ./files/package-plugin.sh /usr/local/bin/package-plugin
COPY ./files/.sw-zip-blacklist.dist /tmp/.sw-zip-blacklist.dist
ADD https://getcomposer.org/composer.phar /usr/local/bin/composer

RUN apk update \
    && apk add bash zip git > /dev/null \
    && chmod +x /usr/local/bin/* \
    && rm -rf /var/cache/apk/*

CMD ["bash"]
