#!/bin/bash
set -o nounset
set -o errexit

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

mkdir -p restore
mkdir -p server
mkdir -p updates

# 172.16.1.102 ist der BCS-Testserver
rsync -avP --no-p --delete root@172.16.1.102:/opt/projektron/bcs/updates/ updates
rsync -avP --no-p --delete root@172.16.1.102:/opt/projektron/bcs/restore/ restore

mkdir -p install

cd install
rm -rf *
cp -v ../updates/projektron-bcs-latest.zip .
unzip projektron-bcs-latest.zip -d server
cp -vR ../repo/* server/
tar cvzf server.tar.gz server/
rm -rf projektron-bcs-latest.zip
rm -rf server
