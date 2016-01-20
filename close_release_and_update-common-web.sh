#!/bin/bash

#todo: if no args print out help explaining what to do

#this is to exit early if any command fails http://stackoverflow.com/questions/1378274/in-a-bash-script-how-can-i-exit-the-entire-script-if-a-certain-condition-occurs
set -e

rm -rf temp
git clone "$1" temp
cd temp
#this is needed to get the following git flow init to work :\
git checkout develop
git checkout master
git flow init -d
#this is needed for release finish to work
git checkout release/$2

#update the common-web reference (when we get npm repo we won't need this...)
node ../update_common_web_reference.js package.json "git+http://gitlab.central.hq.internal/wms/common-web.git#$2"
git add package.json
git commit -m "Updated common-web to point to $2 tag to freeze the dependency"
git push origin release/$2

git flow release finish $2
#push master and tag
git push origin develop
git push origin master
git push --follow-tags
git push origin --delete release/$2
