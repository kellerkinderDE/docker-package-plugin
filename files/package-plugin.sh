#!/bin/bash

packageDirectory="zip_dir"

ZIPNAME="K10rPlugin"
if [ ! "$1" == "" ]; then
    ZIPNAME="$1"
fi

mkdir -p "${packageDirectory}"

for path in `git ls-files | grep -v .gitignore`; do
	file=$(basename "$path")
	dir=$(dirname "$path")

	mkdir -p "${packageDirectory}/${dir}"
	cp "${path}" "${packageDirectory}/${path}"
done

cd "${packageDirectory}"

composer install -qn --no-dev --ignore-platform-reqs

if [ !  -f .sw-zip-blacklist ]; then
    cp -r /tmp/.sw-zip-blacklist.dist .sw-zip-blacklist
fi

while read $b; do
    rm -rf $b
done <.sw-zip-blacklist

rm -rf .sw-zip-blacklist
cd ..
zip -rq $ZIPNAME.zip $packageDirectory/*
rm -rf $packageDirectory
