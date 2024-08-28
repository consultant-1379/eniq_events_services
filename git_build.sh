#!/bin/bash

if [ "$2" == "" ]; then
    	echo usage: $0 \<Branch\> \<Workspace\>
    	exit -1
else
	branch=$2
	workspace=$3
fi


pomFiles=(
  "ee-services-common-utils ./ee-services-common-utils/pom.xml"
  "ee-services-core ./ee-services-core/pom.xml"
  "ee-services-feature ./ee-services-feature/pom.xml"
  "ee-services-jdbc ./ee-services-jdbc/pom.xml"
  "ee-services-logging ./ee-services-logging/pom.xml"
  "ee-services-test ./ee-services-test/pom.xml"
  "eniq-events-services-parent ./pom.xml"
)

GroupId="com.ericsson.eniq.events"
MAVEN="/proj/$USER/apache-maven-3.0.4_oge/bin/mvn"
#RepoURL="=http://eselivm2v214l.lmera.ericsson.se:8081/nexus/content/repositories/releases"
#RepoURL="http://eselivm2v238l.lmera.ericsson.se:8081/nexus/content/repositories/assure-releases"
RepoURL="https://arm1s11-eiffel004.eiffel.gic.ericsson.se:8443/nexus/content/repositories/assure-releases"
Version="16.0-A"


for i in "${pomFiles[@]}"
do
  ArtifactId=$( echo $i | awk -F " " '{print $1}' )
  pomFile=$( echo $i | awk -F " " '{print $2}' )

  ${MAVEN} deploy:deploy-file \
        -Durl=${RepoURL} \
		-N \
        -DrepositoryId=assure-releases \
        -Dpackaging=pom \
        -DgroupId=${GroupId} \
        -Dversion=${Version} \
        -DartifactId=${ArtifactId} \
        -Dfile=${pomFile}

done
