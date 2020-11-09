#!/bin/bash

PROJECT_NAME="$1"
[ -z "$PROJECT_NAME" ] && PROJECT_NAME="$CI_PROJECT_NAME"
[ -z "$PROJECT_NAME" ] && PROJECT_NAME="K10rPlugin"

mkdir -p "${PROJECT_NAME}"

for path in `git ls-files | grep -v .gitignore`; do
        file=$(basename "$path")
        dir=$(dirname "$path")

        mkdir -p "${PROJECT_NAME}/${dir}"
        cp "${path}" "${PROJECT_NAME}/${path}"
done

pushd "${PROJECT_NAME}"

composer install -qno --no-dev --ignore-platform-reqs

if [ ! -f .sw-zip-allowlist ]; then
    cp -r /Users/a.wink/scripts/.zip-allowlist .zip-allowlist
fi

comm -2 -3 <(ls -a) <(sort .zip-allowlist) | tail +2 | xargs rm -rf
rm -rf .zip-allowlist

popd
