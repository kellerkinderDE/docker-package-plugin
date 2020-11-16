FROM edbizarro/gitlab-ci-pipeline-php:7.3

COPY ./files/package-plugin.sh /usr/local/bin/package-plugin
COPY ./files/.sw-zip-blacklist.dist /tmp/.sw-zip-blacklist.dist

CMD ["php", "-a"]
