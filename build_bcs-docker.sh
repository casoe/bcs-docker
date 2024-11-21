#!/bin/bash
set -o nounset
set -o errexit

PROJEKTRON_VERSION=projektron-bcs-24.1.27

mkdir -p repo

if [ -z "$(ls -A repo)" ]; then
  echo "Order repo leer, initiales git clone"
  FILE=.token
  if [ ! -f $FILE ]; then
    echo "File mit Zugangsdaten fehlt"
    exit
  fi
  source $FILE
  git clone https://oauth2:$TOKEN@git.inform-software.com/gb30-bcs/gs3-bcs.git repo
else
  echo "Ordner repo nicht leer, git pull für update"
  git -C repo/ pull
fi

mkdir -p data
mkdir -p updates

# 172.16.1.102 is the BCS test server
rsync -avP --no-p --delete csoehren@172.16.1.102:/opt/projektron/bcs/restore/files/ data/files
rsync -avP --no-p --delete csoehren@172.16.1.102:/opt/projektron/bcs/restore/ftindex/ data/ftindex
rsync -avP --no-p --delete csoehren@172.16.1.102:/opt/projektron/bcs/restore/db/ db
rsync -avP --no-p --delete csoehren@172.16.1.102:/opt/projektron/bcs/updates/ updates

mkdir -p log
mkdir -p log/cron

mkdir -p install

cd install
rm -rf *
cp -v ../updates/$PROJEKTRON_VERSION.zip .
unzip $PROJEKTRON_VERSION.zip -d server
cp -vr ../repo/* server/
rm -vrf server/conf*
rm -vrf server/tomcat*

cd server
tar cvzf ../server.tar.gz .

cd ..
rm -rf $PROJEKTRON_VERSION.zip
rm -rf server

cd ..
docker build -t bcs .
