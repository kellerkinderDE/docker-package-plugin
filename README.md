# kellerkinder/docker-shopware-package-plugin
Image to zip shopware plugins without all unneded files
- Executes composer install --no-dev on installation to remove dev-dependencies
## Usage
### gitlab-ci
```
test-k10r-package-plugin:
    image: kellerkinder/shopware-package-plugin:latest
script:
    - package-plugin #optional param = zip name
artifacts:
    - K10rPlugin.zip #default name
```
