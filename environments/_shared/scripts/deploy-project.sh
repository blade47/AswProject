#!/bin/bash

source "/home/asw/_shared/scripts/common.sh"

#deploy all projects found in deploy
function deployWars {
    for proj_war in /usr/local/wildfly-11.0.0.Final/standalone/*.war; do
        echo "deploying $proj_war"
        /usr/local/wildfly-11.0.0.Final/bin/jboss-cli.sh -c "deploy $proj_war"
    done
}

#generazione del war SpringBootBasic.war
#cd /home/asw/_shared/deploy/SpringBootBasic
#mvn clean package

sudo cp ${ASW_DEPLOY_FOLDER}/SpringBootBasic/target/SpringBootBasic.war /usr/local/wildfly-11.0.0.Final/standalone/

sudo cp ${ASW_DEPLOY_FOLDER}/hello-ejb-impl.jar /usr/local/wildfly-11.0.0.Final/standalone/
sudo cp ${ASW_DEPLOY_FOLDER}/hello-ejb-interface.jar /usr/local/wildfly-11.0.0.Final/standalone/

deployWars
