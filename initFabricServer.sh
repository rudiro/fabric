#!/bin/bash

cd ./composer/
chmod +x howtobuild.sh
./howtobuild.sh

sudo echo "10.160.2.5     orderer0        orderer0.example.com" >> /etc/hosts

export FABRIC_START_TIMEOUT=20

cd ..
./startFabric.sh


chmod +x createPeerAdminCard.sh
./createPeerAdminCard.sh

#nohup composer-playground &
composer-playground