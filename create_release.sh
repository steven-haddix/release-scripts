#!/bin/bash

# Args
# [1] - Path of repository to clone and do work on
# [2] - tag message

set -e


rm -rf temp
git clone "$1" temp
cd temp

#create release branch
git checkout develop
git checkout master
git merge develop


#tag from version number here
CURRENT_TAG=$(git describe --abbrev=0  --tags)
NEW_TAG=$(node ../update_minor_version.js "$CURRENT_TAG")
git tag -a $NEW_TAG -m "$2"

#push master and tag
git push origin --follow-tags
