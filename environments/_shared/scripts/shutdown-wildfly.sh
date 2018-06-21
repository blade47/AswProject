#!/bin/bash

#Shutdown di wildfly
WILDFLY_VERSION=13.0.0.Final

sudo /usr/local/wildfly-${WILDFLY_VERSION}/bin/jboss-cli.sh --connect command=:shutdown
