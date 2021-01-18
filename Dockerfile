FROM dockware/dev:6.3.3.1

COPY ./files/package-plugin.sh /usr/local/bin/package-plugin
COPY ./files/.sw-zip-blocklist.dist /tmp/.sw-zip-blocklist.dist

RUN curl https://getcomposer.org/download/1.10.19/composer.phar -o /var/www/html/composer \
    && chmod +x /var/www/html/composer \
    && /var/www/html/composer global require hirak/prestissimo \
    && cd /var/www/html/ && rm -rf vendor \
    && /var/www/html/composer install --prefer-dist --no-ansi --no-interaction --no-progress --optimize-autoloader --no-scripts \
    && /var/www/html/composer dump-autoload -o

CMD ['php', '-a']
