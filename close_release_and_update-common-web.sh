#!/bin/bash

# Args
# [0] - Path of repository to clone and do work on
# [1] - Release branch name Ex. jan2 would checkout release/jan2

#this is to exit early if any command fails http://stackoverflow.com/questions/1378274/in-a-bash-script-how-can-i-exit-the-entire-script-if-a-certain-condition-occurs
set -e

rm -rf temp
git clone "$1" temp
cd temp

#update common-web reference before tagging from release branch
git checkout release/$2
node ../update_common_web_reference.js package.json "git+http://gitlab.central.hq.internal/wms/common-web.git#$2"
git add package.json
git commit -m "Updated common-web to point to $2 tag to freeze the dependency"

#tag release
git tag -a $2 -m "tag created for $2 release"

#merge to master
git checkout master
git merge release/$2

#merge to develop
git checkout develop
git merge master

#push master, develop, and tag and cleanup release branch
git push origin develop
git push origin master
git push --follow-tags
git push origin --delete release/$2