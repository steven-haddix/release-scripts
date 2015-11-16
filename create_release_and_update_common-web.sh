#!/bin/bash

#this is to exit early if any command fails http://stackoverflow.com/questions/1378274/in-a-bash-script-how-can-i-exit-the-entire-script-if-a-certain-condition-occurs
set -e

#This calls the create_release.sh script, after updates common-web to stable branch for release
sh create_release.sh $1 $2
#need to go where the create_release.sh script took us
cd temp
npm install "git+http://gitlab.central.hq.internal/wms/common-web.git#release/$2" --save
git commit package.json -m "Updated to release/$2 branch for common-web project"
git push -u origin release/$2
