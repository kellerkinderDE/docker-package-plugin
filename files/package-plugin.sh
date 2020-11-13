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

if [ ! -f .sw-zip-blocklist ]; then
    cp -r /tmp/.sw-zip-blocklist.dist .sw-zip-blocklist
fi

rm -rf $( cat .sw-zip-blocklist )
rm -rf .sw-zip-blocklist #remove blocklist file from project

popd
zip -rq $PROJECT_NAME.zip $PROJECT_NAME
