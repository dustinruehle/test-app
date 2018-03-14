#!/bin/bash

set -e

cf api $CF_API --skip-ssl-validation

cf login -u $CF_USER -p $CF_PASSWORD -o "$CF_ORG" -s "$CF_SPACE"

set -x
set +e

VERSION=$(cat version/version)

cf apps | grep "alarmd" | awk '{ print $1; }' | sed -n -e 's/^.*-//p' | grep $VERSION

if [ $? -eq 0 ]
then
  echo "ERROR: alarmd version already deployed!"
  exit 1

else
  echo "alarmd not found"
fi





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