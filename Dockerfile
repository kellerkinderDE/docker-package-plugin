FROM edbizarro/gitlab-ci-pipeline-php:7.3-alpine

COPY ./files/package-plugin.sh /usr/local/bin/package-plugin
COPY ./files/.zip-allowlist.dist /tmp/.zip-allowlist.dist

CMD ["php", "-a"]
