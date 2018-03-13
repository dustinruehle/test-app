#!/bin/bash

set -u # fail if it finds unbound variables
M2_HOME=${HOME}/.m2/
mkdir -p ${M2_HOME}

M2_LOCAL_REPO="${ROOT_FOLDER}/.m2"
mkdir -p "${M2_LOCAL_REPO}/repository"

echo "Writing settings xml to [${HOME}/.m2/settings.xml]"
echo "Repository Id: ${M2_SETTINGS_REPO_ID}"
echo "Repository Username: ${M2_SETTINGS_REPO_USERNAME}"

set +x

SETTINGS_FILE=${HOME}/.m2/settings.xml

echo "<settings xmlns=\"http://maven.apache.org/SETTINGS/1.0.0\"
      xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
      xsi:schemaLocation=\"http://maven.apache.org/SETTINGS/1.0.0
                          https://maven.apache.org/xsd/settings-1.0.0.xsd\">" > $SETTINGS_FILE

# Write Properties
#for each property append

# Finish file
echo "<localRepository>${M2_LOCAL_REPO}/repository</localRepository>
      <!--
      <mirrors>
          <mirror>
            <id>${M2_SETTINGS_REPO_ID}</id>
            <mirrorOf>*</mirrorOf>
            <url>${M2_SETTINGS_REPO_RELEASE_URI}</url>
            <name>Artifactory</name>
          </mirror>
      </mirrors>
      -->
       <servers>
         <server>
           <id>${M2_SETTINGS_REPO_ID}</id>
           <username>${M2_SETTINGS_REPO_USERNAME}</username>
           <password>${M2_SETTINGS_REPO_PASSWORD}</password>
         </server>
       </servers>
       <profiles>
         <profile>
           <id>artifactory</id>
           <repositories>
               <repository>
                   <id>${M2_SETTINGS_REPO_ID}</id>
                   <name>libs-release</name>
                   <url>${M2_SETTINGS_REPO_RELEASE_URI}</url>
               </repository>
           </repositories>" >> $SETTINGS_FILE

echo "CHECKING FOR MVN PROPERTIES IN [${MVN_PROPERTIES_FILE}]"

if [ -e "${MVN_PROPERTIES_FILE}" ]; then
    echo "Found properties ${MVN_PROPERTIES_FILE} file...adding properties to the settings.xml"
    cat ${MVN_PROPERTIES_FILE} >> $SETTINGS_FILE
fi

echo  "</profile>
       </profiles>
       <activeProfiles>
         <activeProfile>artifactory</activeProfile>
       </activeProfiles>
</settings>" >> $SETTINGS_FILE
set -x

chmod +x $SETTINGS_FILE