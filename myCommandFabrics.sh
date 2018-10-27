cd fabric-1.1-kafka-multi-orderer/composer/
!!! VORSICHT !!!!!! vi config-all/howtobuildterraform.py statische 192 adressen
chmod +x howtobuild.sh
./howtobuild.sh

sudo vi /etc/hosts
10.160.2.5     orderer0        orderer0.example.com
#10.160.2.6     orderer1        orderer1.example.com

cd fabric-1.1-kafka-multi-orderer
./startFabric.sh


chmod +x createPeerAdminCard.sh
./createPeerAdminCard.sh

#nohup composer-playground &
composer-playground

http://http://10.160.2.5:8080/
admin 
adminpw

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)



e80372d2ec77        hyperledger/fabric-peer:x86_64-1.1.0                                                                                                         "peer node start"        About an hour ago   Up About an hour    0.0.0.0:7051->7051/tcp, 0.0.0.0:7053->7053/tcp                             peer0.org1.example.com
1326180c1c12        hyperledger/fabric-peer:x86_64-1.1.0                                                                                                         "peer node start"        About an hour ago   Up About an hour    0.0.0.0:8051->7051/tcp, 0.0.0.0:8053->7053/tcp                             peer1.org1.example.com
c9378eee9284        hyperledger/fabric-orderer:x86_64-1.1.0                                                                                                      "orderer"                About an hour ago   Up About an hour    0.0.0.0:7050->7050/tcp                                                     orderer0.example.com

6ab897104b0e        hyperledger/fabric-couchdb:x86_64-0.4.6                                                                                                      "tini -- /docker-ent…"   About an hour ago   Up About an hour    4369/tcp, 9100/tcp, 0.0.0.0:6984->5984/tcp                                 couchdb1
84de7b51e899        hyperledger/fabric-couchdb:x86_64-0.4.6                                                                                                      "tini -- /docker-ent…"   About an hour ago   Up About an hour    4369/tcp, 9100/tcp, 0.0.0.0:5984->5984/tcp                                 couchdb
f24b2b3c683f        hyperledger/fabric-ca:x86_64-1.1.0                                                                                                           "sh -c 'fabric-ca-se…"   About an hour ago   Up About an hour    0.0.0.0:7054->7054/tcp                                                     ca.org1.example.com




docker ps
ubuntu@ip-192-168-1-5:~/fabric-1.1-kafka-multi-orderer$ docker ps
CONTAINER ID        IMAGE                                     COMMAND                  CREATED             STATUS              PORTS                                                                      NAMES
e80372d2ec77        hyperledger/fabric-peer:x86_64-1.1.0      "peer node start"        2 minutes ago       Up 2 minutes        0.0.0.0:7051->7051/tcp, 0.0.0.0:7053->7053/tcp                             peer0.org1.example.com
1326180c1c12        hyperledger/fabric-peer:x86_64-1.1.0      "peer node start"        2 minutes ago       Up 2 minutes        0.0.0.0:8051->7051/tcp, 0.0.0.0:8053->7053/tcp                             peer1.org1.example.com
c9378eee9284        hyperledger/fabric-orderer:x86_64-1.1.0   "orderer"                2 minutes ago       Up 2 minutes        0.0.0.0:7050->7050/tcp                                                     orderer0.example.com
3aea94b078b5        hyperledger/fabric-kafka                  "/docker-entrypoint.…"   2 minutes ago       Up 2 minutes        9093/tcp, 0.0.0.0:12092->9092/tcp                                          kafka3
c1437d300d6a        hyperledger/fabric-kafka                  "/docker-entrypoint.…"   2 minutes ago       Up 2 minutes        9093/tcp, 0.0.0.0:10092->9092/tcp                                          kafka1
ac3e65f472d0        hyperledger/fabric-kafka                  "/docker-entrypoint.…"   2 minutes ago       Up 2 minutes        0.0.0.0:9092->9092/tcp, 9093/tcp                                           kafka0
bfe70f8a3022        hyperledger/fabric-kafka                  "/docker-entrypoint.…"   2 minutes ago       Up 2 minutes        9093/tcp, 0.0.0.0:11092->9092/tcp                                          kafka2
34d1614aeede        hyperledger/fabric-zookeeper              "/docker-entrypoint.…"   2 minutes ago       Up 2 minutes        0.0.0.0:2181->2181/tcp, 0.0.0.0:32773->2888/tcp, 0.0.0.0:32771->3888/tcp   zookeeper0
5aeebd673f6e        hyperledger/fabric-zookeeper              "/docker-entrypoint.…"   2 minutes ago       Up 2 minutes        0.0.0.0:4181->2181/tcp, 0.0.0.0:32772->2888/tcp, 0.0.0.0:32770->3888/tcp   zookeeper2
1ceba80ec25a        hyperledger/fabric-zookeeper              "/docker-entrypoint.…"   2 minutes ago       Up 2 minutes        0.0.0.0:3181->2181/tcp, 0.0.0.0:32769->2888/tcp, 0.0.0.0:32768->3888/tcp   zookeeper1
6ab897104b0e        hyperledger/fabric-couchdb:x86_64-0.4.6   "tini -- /docker-ent…"   2 minutes ago       Up 2 minutes        4369/tcp, 9100/tcp, 0.0.0.0:6984->5984/tcp                                 couchdb1
84de7b51e899        hyperledger/fabric-couchdb:x86_64-0.4.6   "tini -- /docker-ent…"   2 minutes ago       Up 2 minutes        4369/tcp, 9100/tcp, 0.0.0.0:5984->5984/tcp                                 couchdb
f24b2b3c683f        hyperledger/fabric-ca:x86_64-1.1.0        "sh -c 'fabric-ca-se…"   2 minutes ago       Up 2 minutes        0.0.0.0:7054->7054/tcp                                                     ca.org1.example.com




f267d7fd810        dev-peer1.org1.example.com-vehicle-lifecycle-network-0.2.6-20180803115844-e588b7657f01256a8a9936651dae360652b0941c9d2f456ae92db9c4592d9621   "/bin/sh -c 'cd /usr…"   28 minutes ago      Up 28 minutes                                                                                  dev-peer1.org1.example.com-vehicle-lifecycle-network-0.2.6-20180803115844
a354cfc12754        dev-peer0.org1.example.com-vehicle-lifecycle-network-0.2.6-20180803115844-c7a80e59976ae63eb862de4a24690079553d10bfae86922aea938222ad05d468   "/bin/sh -c 'cd /usr…"   28 minutes ago      Up 28 minutes                                                                                  dev-peer0.org1.example.com-vehicle-lifecycle-network-0.2.6-20180803115844
2c8a96f09d44        dev-peer1.org1.example.com-letters-of-credit-network-0.2.6-20180803115844-bae277875346f44f13ea3cb3a63c6f436ce86bb16f5a64614698408f1109f6f0   "/bin/sh -c 'cd /usr…"   About an hour ago   Up About an hour                                                                               dev-peer1.org1.example.com-letters-of-credit-network-0.2.6-20180803115844
a13e90b13d92        dev-peer0.org1.example.com-letters-of-credit-network-0.2.6-20180803115844-f63e284c72741b7c3a3d74a0dd8f3fb0a717b60c52753b24ef8a3b3f6da48051   "/bin/sh -c 'cd /usr…"   About an hour ago   Up About an hour                                                                               dev-peer0.org1.example.com-letters-of-credit-network-0.2.6-20180803115844
e80372d2ec77        hyperledger/fabric-peer:x86_64-1.1.0                                                                                                         "peer node start"        About an hour ago   Up About an hour    0.0.0.0:7051->7051/tcp, 0.0.0.0:7053->7053/tcp                             peer0.org1.example.com
1326180c1c12        hyperledger/fabric-peer:x86_64-1.1.0                                                                                                         "peer node start"        About an hour ago   Up About an hour    0.0.0.0:8051->7051/tcp, 0.0.0.0:8053->7053/tcp                             peer1.org1.example.com
c9378eee9284        hyperledger/fabric-orderer:x86_64-1.1.0                                                                                                      "orderer"                About an hour ago   Up About an hour    0.0.0.0:7050->7050/tcp                                                     orderer0.example.com
3aea94b078b5        hyperledger/fabric-kafka                                                                                                                     "/docker-entrypoint.…"   About an hour ago   Up About an hour    9093/tcp, 0.0.0.0:12092->9092/tcp                                          kafka3
c1437d300d6a        hyperledger/fabric-kafka                                                                                                                     "/docker-entrypoint.…"   About an hour ago   Up About an hour    9093/tcp, 0.0.0.0:10092->9092/tcp                                          kafka1
ac3e65f472d0        hyperledger/fabric-kafka                                                                                                                     "/docker-entrypoint.…"   About an hour ago   Up About an hour    0.0.0.0:9092->9092/tcp, 9093/tcp                                           kafka0
bfe70f8a3022        hyperledger/fabric-kafka                                                                                                                     "/docker-entrypoint.…"   About an hour ago   Up About an hour    9093/tcp, 0.0.0.0:11092->9092/tcp                                          kafka2
34d1614aeede        hyperledger/fabric-zookeeper                                                                                                                 "/docker-entrypoint.…"   About an hour ago   Up About an hour    0.0.0.0:2181->2181/tcp, 0.0.0.0:32773->2888/tcp, 0.0.0.0:32771->3888/tcp   zookeeper0
5aeebd673f6e        hyperledger/fabric-zookeeper                                                                                                                 "/docker-entrypoint.…"   About an hour ago   Up About an hour    0.0.0.0:4181->2181/tcp, 0.0.0.0:32772->2888/tcp, 0.0.0.0:32770->3888/tcp   zookeeper2
1ceba80ec25a        hyperledger/fabric-zookeeper                                                                                                                 "/docker-entrypoint.…"   About an hour ago   Up About an hour    0.0.0.0:3181->2181/tcp, 0.0.0.0:32769->2888/tcp, 0.0.0.0:32768->3888/tcp   zookeeper1
6ab897104b0e        hyperledger/fabric-couchdb:x86_64-0.4.6                                                                                                      "tini -- /docker-ent…"   About an hour ago   Up About an hour    4369/tcp, 9100/tcp, 0.0.0.0:6984->5984/tcp                                 couchdb1
84de7b51e899        hyperledger/fabric-couchdb:x86_64-0.4.6                                                                                                      "tini -- /docker-ent…"   About an hour ago   Up About an hour    4369/tcp, 9100/tcp, 0.0.0.0:5984->5984/tcp                                 couchdb
f24b2b3c683f        hyperledger/fabric-ca:x86_64-1.1.0                                                                                                           "sh -c 'fabric-ca-se…"   About an hour ago   Up About an hour    0.0.0.0:7054->7054/tcp                                                     ca.org1.example.com
