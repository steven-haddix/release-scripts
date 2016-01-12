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
git checkout hotfix/$2
git flow hotfix finish $2
#push master and tag
git push origin develop
git push origin master
git push --follow-tags
git push origin --delete hotfix/$2
