#!/bin/bash

# Args
# [0] - Path of repository to clone and do work on
# [1] - Release branch name Ex. jan2 would checkout release/jan2

#todo: if no args print out help explaining what to do
set -e

rm -rf temp
git clone "$1" temp
cd temp

#create release branch
git checkout develop
git checkout -b release/$2

#update common-web reference
node ../update_common_web_reference.js package.json "git+http://gitlab.central.hq.internal/wms/common-web.git#release/$2"
git add package.json
git commit -m "Updated common-web to point to release/$2 branch"

#push
git push origin release/$2