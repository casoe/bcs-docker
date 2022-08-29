#!/bin/bash

# Linux
wget=/usr/bin/wget
unzip=/usr/bin/unzip
tail=/usr/bin/tail
bash=/bin/bash

# Variables defined in docker run
echo "Variables are:"
echo "BCS=$BCS"
echo "JAVA=$JAVA_HOME"
echo "TOMCAT=$TOMCAT_HOME"
echo "BCS_VERSION=$PROJEKTRON_VERSION"
echo "Database lib=$DBLIB"
echo "License=$LICENSE"

# Using the first 4 chars of the minor version, to get major version (e.g. 7.30.10 -> 7.30)
projektron_minor=$PROJEKTRON_VERSION
projektron_major=${projektron_minor:0:4}
echo "Minor Projektron Version=$projektron_minor"
echo "Major Projektron Version=$projektron_major"

#Change to /scripts and check if install file exists
cd /scripts
if [ -e projektron-bcs-$projektron_minor.zip ]
then
  echo "Install file exists, using projektron-bcs-$projektron_minor.zip"
else
  # Download specified Projektron Version to /scripts directory, if not yet existent
  echo "Error: missing file"
	exit 1
fi

# Unzip downloaded file to BCS directory and remove zip file
unzip -o projektron-bcs-$projektron_minor.zip -d $BCS

# Last step start tomcat server
cd $TOMCAT_HOME/bin
bash -c startup.sh
echo "Tomcat running, wait to read logs"
sleep 5
tail -f ../logs/catalina.out
