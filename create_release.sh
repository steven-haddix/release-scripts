#!/bin/bash

#todo: if no args print out help explaining what to do

rm -rf temp
git clone "$1" temp
cd temp
#this is needed to get the following git flow init to work :\
git checkout develop
git checkout master
git flow init -d
git flow release start $2
git push origin release/$2

