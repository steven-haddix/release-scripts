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
git checkout master
git merge develop
#todo: tag from version number here
git push origin --follow-tags