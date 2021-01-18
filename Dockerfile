FROM dockware/dev:6.3.3.1

COPY ./files/package-plugin.sh /usr/local/bin/package-plugin
COPY ./files/.sw-zip-blocklist.dist /tmp/.sw-zip-blocklist.dist

RUN cd /var/www/html/ && rm -rf vendor \
    && composer install --prefer-dist --no-ansi --no-interaction --no-progress --optimize-autoloader --no-scripts \
    && composer dump-autoload -o

CMD ['php', '-a']
