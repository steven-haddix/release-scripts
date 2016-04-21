#!/bin/bash

# Args
# [0] - Path of repository to clone and do work on
# [1] - tag name (this can be automated with 'git describe' command)
# [2] - Common-web tag to freeze dependency
# [3] - Message for tag

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
node ../update_common_web_reference.js package.json "git+http://gitlab.central.hq.internal/wms/common-web.git#$3"
git add package.json
git commit -m "Updated common-web to point to $3 branch"

#tag
git tag -a $2 -m "$4"

#push
git push origin --follow-tags