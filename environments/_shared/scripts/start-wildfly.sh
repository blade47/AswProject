#!/bin/bash
WILDFLY_VERSION=13.0.0.Final

sudo /usr/local/wildfly-${WILDFLY_VERSION}/bin/standalone.sh -b=0.0.0.0 &
