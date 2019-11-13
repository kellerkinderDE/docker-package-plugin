# kellerkinder/docker-shopware-package-plugin
Image to zip shopware plugins without all unneeded files
- Executes `composer install -qno --no-dev --ignore-platform-reqs` on installation to remove dev-dependencies
## Usage
### gitlab-ci
```
test-k10r-package-plugin:
    image: kellerkinder/shopware-package-plugin:latest
script:
    - package-plugin #optional param = zip name
artifacts:
    - $CI_PROJECT_NAME.zip #default name
```
