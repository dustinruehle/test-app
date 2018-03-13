#!/bin/bash

# Get the artifact from nexus
version=$(cat version/version)
if [[ -z $version ]]; then
    echo "No version specified.  Using latest version"
    version=LATEST
else
    version=$version-SNAPSHOT
fi
wget "http://build.utilities.west.com:8081/nexus/service/local/artifact/maven/redirect?r=${NEXUS_REPO}&g=${MAVEN_GROUP_ID}&a=${MAVEN_ARTIFACT_ID}&v=${version}" -O ${JAR_NAME}

wgetreturn=$?
if [[ $wgetreturn -ne 0 ]]; then
    echo "Failed to download JAR."
    exit 1
fi

# Get the manifest from nexus
wget "http://build.utilities.west.com:8081/nexus/service/local/artifact/maven/redirect?r=${NEXUS_REPO}&g=${MAVEN_GROUP_ID}&a=${MAVEN_ARTIFACT_ID}&v=${version}&e=YML" -O manifest.yml
wgetreturn=$?
if [[ $wgetreturn -ne 0 ]]; then
    echo "Failed to download Manifest."
    exit 1
fi


cp ${JAR_NAME} deploy-output/.
cp manifest.yml deploy-output/.

set -x
