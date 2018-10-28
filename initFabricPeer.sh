#!/bin/bash

cd fabric-1.1-kafka-multi-orderer/composer/
chmod +x howtobuild.sh
./howtobuild.sh

sudo echo "10.160.2.5     orderer0        orderer0.example.com" >> /etc/hosts

export FABRIC_START_TIMEOUT=20

cd ..
chmod +x startFabric-Peer2.sh

./startFabric-Peer2.sh


chmod +x createPeerAdminCard.sh
./createPeerAdminCard.sh

composer-playground