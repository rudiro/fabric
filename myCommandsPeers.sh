sudo vi /etc/hosts
10.160.2.5     orderer0        orderer0.example.com
#10.160.2.6     orderer1        orderer1.example.com

export FABRIC_START_TIMEOUT=30
cd fabric-1.1-kafka-multi-orderer/

chmod +x startFabric-Peer2.sh

./startFabric-Peer2.sh


chmod +x createPeerAdminCard.sh
./createPeerAdminCard.sh

nohup composer-playground &

composer-playground

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

9a71084dcac5        hyperledger/fabric-orderer:x86_64-1.2.0                                                                                                      "orderer"                About an hour ago   Up About an hour    0.0.0.0:7050->7050/tcp                             orderer1.example.com
18e29827a615        hyperledger/fabric-peer:x86_64-1.2.0                                                                                                         "peer node start"        About an hour ago   Up About an hour    0.0.0.0:10051->7051/tcp, 0.0.0.0:10053->7053/tcp   peer3.org1.example.com
dc51fc223456        hyperledger/fabric-peer:x86_64-1.2.0                                                                                                         "peer node start"        About an hour ago   Up About an hour    0.0.0.0:9051->7051/tcp, 0.0.0.0:9053->7053/tcp     peer2.org1.example.com
a05201f41f06        hyperledger/fabric-couchdb:x86_64-0.4.6                                                                                                      "tini -- /docker-ent…"   About an hour ago   Up About an hour    4369/tcp, 9100/tcp, 0.0.0.0:8984->5984/tcp         couchdb3
91dc367d6239        hyperledger/fabric-couchdb:x86_64-0.4.6                                                                                                      "tini -- /docker-ent…"   About an hour ago   Up About an hour    4369/tcp, 9100/tcp, 0.0.0.0:7984->5984/tcp         couchdb2




ubuntu@ip-192-168-1-6:~/fabric-1.1-kafka-multi-orderer$ docker ps
CONTAINER ID        IMAGE                                     COMMAND                  CREATED             STATUS              PORTS                                              NAMES
9a71084dcac5        hyperledger/fabric-orderer:x86_64-1.2.0   "orderer"                10 minutes ago      Up 10 minutes       0.0.0.0:7050->7050/tcp                             orderer1.example.com
18e29827a615        hyperledger/fabric-peer:x86_64-1.2.0      "peer node start"        10 minutes ago      Up 10 minutes       0.0.0.0:10051->7051/tcp, 0.0.0.0:10053->7053/tcp   peer3.org1.example.com
dc51fc223456        hyperledger/fabric-peer:x86_64-1.2.0      "peer node start"        10 minutes ago      Up 10 minutes       0.0.0.0:9051->7051/tcp, 0.0.0.0:9053->7053/tcp     peer2.org1.example.com
4e01c5893903        hyperledger/fabric-kafka                  "/docker-entrypoint.…"   10 minutes ago      Up 10 minutes       9093/tcp, 0.0.0.0:10092->9092/tcp                  kafka5
cc44fcdd319f        hyperledger/fabric-kafka                  "/docker-entrypoint.…"   10 minutes ago      Up 10 minutes       9093/tcp, 0.0.0.0:11092->9092/tcp                  kafka6
552f3ed36d1a        hyperledger/fabric-kafka                  "/docker-entrypoint.…"   10 minutes ago      Up 10 minutes       9093/tcp, 0.0.0.0:12092->9092/tcp                  kafka7
d7220d59bf06        hyperledger/fabric-kafka                  "/docker-entrypoint.…"   10 minutes ago      Up 10 minutes       0.0.0.0:9092->9092/tcp, 9093/tcp                   kafka4
a05201f41f06        hyperledger/fabric-couchdb:x86_64-0.4.6   "tini -- /docker-ent…"   10 minutes ago      Up 10 minutes       4369/tcp, 9100/tcp, 0.0.0.0:8984->5984/tcp         couchdb3
91dc367d6239        hyperledger/fabric-couchdb:x86_64-0.4.6   "tini -- /docker-ent…"   10 minutes ago      Up 10 minutes       4369/tcp, 9100/tcp, 0.0.0.0:7984->5984/tcp         couchdb2
