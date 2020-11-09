# docker-package-plugin

Image to zip shopware plugins without any unneeded files
- Executes `composer install -qno --no-dev --ignore-platform-reqs` on installation to remove dev-dependencies
- Removes all files not listed in `.zip-allowlist`

## Usage

### Example gitlab-ci job
```
k10r-package-plugin:
    image: kellerkinder/shopware-package-plugin:latest
script:
    - package-plugin #optional param = folder name
artifacts:
    paths:
        - $CI_PROJECT_NAME # default name
```

## Extensions

You may want to add [FroshPluginUploader](https://github.com/FriendsOfShopware/FroshPluginUploader) to your CI pipeline, e.g. to validate your plugin or directly upload a tagged release.
