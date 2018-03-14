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
