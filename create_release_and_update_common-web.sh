#!/bin/bash

# Args
# [0] - Path of repository to clone and do work on
# [1] - Common-web tag to freeze dependency
# [2] - Message for tag

#todo: if no args print out help explaining what to do
set -e

rm -rf temp
git clone "$1" temp
cd temp

#create release branch
git checkout develop
git checkout master
git merge develop

#update common-web reference
node ../update_common_web_reference.js package.json "git+http://gitlab.central.hq.internal/wms/common-web.git#$2"
git add package.json
git commit -m "Updated common-web to point to $2 branch" || true

#tag
CURRENT_TAG=$(git describe --abbrev=0  --tags)
NEW_TAG=$(node ../update_minor_version.js "$CURRENT_TAG")
git tag -a $NEW_TAG -m "$3"

#push master and tag
git push origin --follow-tags
