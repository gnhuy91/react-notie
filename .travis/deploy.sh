#!/bin/bash
#
echo $TRAVIS_BRANCH

if ([ "$TRAVIS_BRANCH" != "master" ] && [ -z "$TRAVIS_TAG" ]) ||  [ "$TRAVIS_PULL_REQUEST" != "false" ];
then
	exit
fi

set -o errexit

# copy required files
npm run build:examples

cd public
git init

git config --global user.name "Travis CI"
git config --global user.email "vkb0310@gmail.com"

git add .
git commit -m "Deploy to gh-pages"

git push --force --quiet "https://${GITHUB_TOKEN}@github.com/${GITHUB_REPO}.git" master:gh-pages > /dev/null 2>&1
