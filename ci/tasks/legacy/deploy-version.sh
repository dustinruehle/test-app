#!/bin/bash

# input folders:
# version : contains a file called number with the current version
# source-code : contains the source code

# output folders:
# build: contains the built jar

set -e

echo "Hello workd!"








#export ROOT_FOLDER=$( pwd )
#source ./pipeline/tasks/common.sh
#
#
#echo "Generating maven settings.xml"
#./pipeline/tasks/generate-settings.sh
#
#VERSION=$(cat version/version)
#echo "Semver Resource Version is=$VERSION"
#
#echo "Building artifact ..."
#cd source-code
#mvn clean verify
#
#
#echo "Setting maven with version to build ..."
#mvn versions:set -DnewVersion=${VERSION}-SNAPSHOT
#
#echo "Uploading artifact ..."
#mvn deploy ${MAVEN_ARGS} -DskipTests=true



#cd repo
#mvn clean package -Dmaven.repo.local=../.m2/repository -DskipTests=true
#cp target/bda-web-*.jar ../artifacts/.
#
#echo "dev/$VERSION" > tag
#
#cp -Rp . ../repo-tag/.