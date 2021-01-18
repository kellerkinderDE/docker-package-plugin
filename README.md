# docker-package-plugin

Image to zip shopware plugins without any unneeded files
- Executes `composer install -qno --no-dev --ignore-platform-reqs` on installation to remove dev-dependencies

## Usage

### Example GitLab CI job
#### Packing only
```
package:
    image: kellerkinder/shopware-package-plugin:v1.0.0
    script:
        - package-plugin #optional param = zip name
    artifacts:
        paths:
            - ${CI_PROJECT_NAME}.zip #default name
```
#### Compile and pack
```
package:
    image: kellerkinder/shopware-package-plugin:v1.0.0
    before_script:
        - ${COMPOSER_COMMAND}
        - cp -r ${CI_PROJECT_DIR} /var/www/html/custom/plugins/${CI_PROJECT_NAME}
        - sudo rm -rf /var/run/mysqld/mysqld.sock.lock
        - sudo chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
        - sudo service mysql start
    script:
        - php /var/www/html/bin/console plugin:refresh -nq && php /var/www/html/bin/console plugin:install --activate -cnq ${CI_PROJECT_NAME}
        - /var/www/html/bin/build-administration.sh
        - /var/www/html/bin/build-storefront.sh
        - php /var/www/html/bin/console theme:compile -nq
        - rsync -r /var/www/html/custom/plugins/${CI_PROJECT_NAME}/* ${CI_PROJECT_DIR}/
        - sudo chown www-data:www-data ./* -R && sudo chown www-data:www-data ./.gi* -R
        - git add -f .
        - package-plugin #optional param = zip name
        - unzip -vl ${CI_PROJECT_NAME}.zip
    artifacts:
        paths:
            - ${CI_PROJECT_NAME}.zip #default name
```

## Extensions

You may want to add [FroshPluginUploader](https://github.com/FriendsOfShopware/FroshPluginUploader) to your CI pipeline, e.g. to validate your plugin or directly upload a tagged release.
