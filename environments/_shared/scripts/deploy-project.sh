#!/bin/bash

source "/home/asw/_shared/scripts/common.sh"
WILDFLY_VERSION=13.0.0.Final

#deploy all projects found in deploy
function deployWars {
    for proj_war in /usr/local/wildfly-${WILDFLY_VERSION}/standalone/*.war; do
        echo "deploying $proj_war"
        /usr/local/wildfly-11.0.0.Final/bin/jboss-cli.sh -c "deploy $proj_war"
    done
}

#Script che effettua il deploy di qualsiasi progetto .war all'interno della cartella /usr/local/wildfly-${WILDFLY_VERSION}/standalone/
#Esempio:
#	1. Generazione del war SpringBootBasic.war
#		cd /home/asw/_shared/deploy/SpringBootBasic
#		mvn clean package
#
#	2. Copia del .war in standalone
#		sudo cp ${ASW_DEPLOY_FOLDER}/SpringBootBasic/target/SpringBootBasic.war /usr/local/wildfly-11.0.0.Final/standalone/

deployWars
