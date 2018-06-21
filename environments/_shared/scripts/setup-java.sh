#!/bin/bash

source "/home/asw/_shared/scripts/common.sh"

# set up Java constants 
JAVA_VERSION=8
JAVA_MINOR_VERSION=171
JAVA_BUILD=11
JAVA_HEX=512cd62ec5174c3487ac17c61aaa89e8

# e.g, http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz

JAVA_FILE_NAME=jdk-${JAVA_VERSION}u${JAVA_MINOR_VERSION}-linux-x64
JAVA_ARCHIVE=${JAVA_FILE_NAME}.tar.gz
GET_JAVA_URL=http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_MINOR_VERSION}-b${JAVA_BUILD}/${JAVA_HEX}
JAVA_JDK_PATH=/usr/local/jdk1.${JAVA_VERSION}.0_${JAVA_MINOR_VERSION} 
# e.g., /usr/local/jdk1.8.0_161
JAVA_JRE_PATH=/usr/lib/jvm/jre 

function installLocalJava {
	echo "====================="
	echo "installing oracle jdk"
	echo "====================="
	FILE=${ASW_DOWNLOADS}/$JAVA_ARCHIVE
	tar -xzf $FILE -C /usr/local
}

function installRemoteJava {
	echo "======================"
	echo "downloading oracle jdk"
	echo "======================"
	wget -nv -P ${ASW_DOWNLOADS} --header "Cookie: oraclelicense=accept-securebackup-cookie;" "${GET_JAVA_URL}/${JAVA_ARCHIVE}" 
	installLocalJava 
}

function setupJava {
	echo "setting up java"
	if downloadExists $JAVA_ARCHIVE; then
		ln -s $JAVA_JDK_PATH /usr/local/java
	else
		ln -s $JAVA_JRE_PATH /usr/local/java
	fi
}

function setupEnvVars {
	echo "creating java environment variables"
	JAVA_HOME=/usr/local/jdk1.${JAVA_VERSION}.0_${JAVA_MINOR_VERSION}/
	sudo update-alternatives --install /usr/bin/java java ${JAVA_HOME%*/}/bin/java 20000
	sudo update-alternatives --install /usr/bin/javac javac ${JAVA_HOME%*/}/bin/javac 20000
}

function installJava {
	if downloadExists $JAVA_ARCHIVE; then
		installLocalJava
	else
		installRemoteJava
	fi
}

echo "setup java"
installJava
setupJava
setupEnvVars
