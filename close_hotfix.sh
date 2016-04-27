#!/bin/bash

# Args
# [1] - Path of repository to clone and do work on
# [2] - Hotfix branch to close out and tag
# [3] - Tag message

#this is to exit early if any command fails http://stackoverflow.com/questions/1378274/in-a-bash-script-how-can-i-exit-the-entire-script-if-a-certain-condition-occurs
set -e

rm -rf temp
git clone "$1" temp
cd temp

#get to the hotfix branch
git checkout $2

# lets get the last tag!
CURRENT_TAG=$(git describe --abbrev=0  --tags)
ECHO "CURRENT_TAG=$CURRENT_TAG"
NEW_TAG=$(node ../update_patch_level.js "$CURRENT_TAG")
ECHO "NEW_TAG=$NEW_TAG"

#tag from hotfix branch with new patch level
git tag -a $NEW_TAG -m "$3"

#merge to master
git checkout master
git merge $2

#merge to develop
git checkout develop
git merge master

#push master
git push origin master
#push develop
git push origin develop
#push tag
git push origin --follow-tags
#delete hotfix branch
git push origin --delete $2