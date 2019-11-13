#!/bin/bash

PROJECT_NAME="$1"
if [ "$PROJECT_NAME" == "" ]; then
    PROJECT_NAME="$CI_PROJECT_NAME"
fi

if [ "$PROJECT_NAME" == "" ]; then
    PROJECT_NAME="K10rPlugin"
fi

mkdir -p "${PROJECT_NAME}"

for path in `git ls-files | grep -v .gitignore`; do
	file=$(basename "$path")
	dir=$(dirname "$path")

	mkdir -p "${PROJECT_NAME}/${dir}"
	cp "${path}" "${PROJECT_NAME}/${path}"
done

cd "${PROJECT_NAME}"

composer install -qno --no-dev --ignore-platform-reqs

if [ ! -f .sw-zip-blacklist ]; then
    cp -r /tmp/.sw-zip-blacklist.dist .sw-zip-blacklist
fi

cd ..
zip -rq $PROJECT_NAME.zip $PROJECT_NAME --exclude @$PROJECT_NAME/.sw-zip-blacklist $PROJECT_NAME/.sw-zip-blacklist
