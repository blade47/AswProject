#!/bin/bash

source "/home/asw/_shared/scripts/common.sh"
#tutorial
WILDFLY_VERSION=11.0.0.Final
WILDFLY_FILENAME=wildfly-$WILDFLY_VERSION
WILDFLY_ARCHIVE=$WILDFLY_FILENAME.tar.gz
GET_WILDFLY_URL=http://download.jboss.org/wildfly/$WILDFLY_VERSION/$WILDFLY_ARCHIVE

WILDFLY_PATH=/usr/local/wildfly-${WILDFLY_VERSION} 

function installLocalWildfly {
	echo "====================="
	echo "installing wildfly"
	echo "====================="
	FILE=${ASW_DOWNLOADS}/$WILDFLY_ARCHIVE
	tar -xzf $FILE -C /usr/local
}

function installRemoteWildfly {
	echo "======================"
	echo "downloading wildfly"
	echo "======================"
	wget -nv -P ${ASW_DOWNLOADS} "${GET_WILDFLY_URL}"
	
	installLocalWildfly 
}

function setupWildfly {
	echo "setting up wildfly"
	if downloadExists $WILDFLY_ARCHIVE; then
		ln -s $WILDFLY_PATH /usr/local/wildfly-${WILDFLY_VERSION}
	else
		echo "setup didn't work"
	fi
}

 function setupEnvVars {
 	echo "creating wildfly environment variables"
 	echo "primo passo: jboss home"
    echo export JBOSS_HOME=/usr/local/wildfly-${WILDFLY_VERSION} >> /etc/profile.d/wildfly.sh
 	echo "secondo passo: jboss home bin"
	echo export PATH=\${JBOSS_HOME}/bin:\${PATH} >> /etc/profile.d/wildfly.sh
	
	chmod +x /usr/local/wildfly-${WILDFLY_VERSION}/bin/standalone.sh
    chmod u+x /home/asw/_shared/scripts/start-wildfly.sh
    chmod u+x /home/asw/_shared/scripts/service/start-wildfly-service.sh
    chmod u+x /home/asw/_shared/scripts/deploy-project.sh
 }

function installWildfly {
	if downloadExists $WILDFLY_ARCHIVE; then
		installLocalWildfly
	else
		installRemoteWildfly
	fi
}

echo "setup wildfly"
installWildfly
setupWildfly
setupEnvVars


