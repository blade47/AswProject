#!/bin/bash

ASW_HOME=/home/asw 
ASW_DOWNLOADS=${ASW_HOME}/_shared/downloads
ASW_RESOURCES=${ASW_HOME}/_shared/resources
ASW_DEPLOY_FOLDER=${ASW_HOME}/_shared/deploy

function downloadExists {
	FILE=${ASW_DOWNLOADS}/$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

function fileExists {
	FILE=$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

#echo "common loaded"
