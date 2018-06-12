#!/bin/bash

#setup wildfly as a service
sudo cp /home/asw/_shared/scripts/service/wildfly.service /etc/systemd/system/

#start wildfly service
sudo systemctl start wildfly.service

