#!/bin/bash

# Args
# [0] - Path of repository to clone and do work on
# [1] - Release branch name Ex. jan2 would checkout release/jan2

#this is to exit early if any command fails http://stackoverflow.com/questions/1378274/in-a-bash-script-how-can-i-exit-the-entire-script-if-a-certain-condition-occurs
set -e

rm -rf temp
git clone "$1" temp
cd temp

#tag off release branch
git checkout release/$2
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
