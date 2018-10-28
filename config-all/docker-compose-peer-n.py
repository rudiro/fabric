import string
from sys import argv

script, arg1 = argv
arg1 = int(arg1)
arg1 -= 1

for i in range(arg1):
    file = """version: '2'

services:
  orderer""" + str(i + 1) + """.example.com:
    container_name: orderer""" + str(i + 1) + """.example.com
    image: hyperledger/fabric-orderer:1.2.0
    environment:
      - ORDERER_GENERAL_LOGLEVEL=debug
      - ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
      - ORDERER_GENERAL_GENESISMETHOD=file
      - ORDERER_GENERAL_GENESISFILE=/etc/hyperledger/configtx/composer-genesis.block
      - ORDERER_GENERAL_LOCALMSPID=OrdererMSP
      - ORDERER_GENERAL_LOCALMSPDIR=/etc/hyperledger/msp/orderer/msp
      # enabled TLS
      - ORDERER_GENERAL_TLS_ENABLED=true
      - ORDERER_GENERAL_TLS_PRIVATEKEY=/etc/hyperledger/tls/orderer/tls/server.key
      - ORDERER_GENERAL_TLS_CERTIFICATE=/etc/hyperledger/tls/orderer/tls/server.crt
      - ORDERER_GENERAL_TLS_ROOTCAS=[/etc/hyperledger/tls/orderer/tls/ca.crt]
      - ORDERER_KAFKA_RETRY_SHORTINTERVAL=1s
      - ORDERER_KAFKA_RETRY_SHORTTOTAL=30s
      - ORDERER_KAFKA_VERBOSE=true
      - CONFIGTX_ORDERER_KAFKA_BROKERS=[10.160.19.79:9092, 10.160.19.143:9092, 10.160.19.207:9092]
    working_dir: /opt/gopath/src/github.com/hyperledger/fabric
    command: orderer
    ports:
      - 7050:7050
    volumes:
        - ./:/etc/hyperledger/configtx
        - ./crypto-config/ordererOrganizations/example.com/orderers/orderer""" + str(i + 1) + """.example.com/msp:/etc/hyperledger/msp/orderer/msp
        - ./crypto-config/ordererOrganizations/example.com/orderers/orderer""" + str(i + 1) + """.example.com/tls:/etc/hyperledger/tls/orderer/tls
        - ./orderer""" + str(i + 1) + """.example.com:/var/hyperledger/production/orderer

  peer""" + str(2 + (i*2)) + """.org1.example.com:
    container_name: peer""" + str(2 + (i*2)) + """.org1.example.com
    image: hyperledger/fabric-peer:1.2.0
    environment:
      - CORE_LOGGING_PEER=debug
      - CORE_CHAINCODE_LOGGING_LEVEL=DEBUG
      - CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock
      - CORE_PEER_ID=peer""" + str(2 + (i*2)) + """.org1.example.com
      - CORE_PEER_ADDRESS=peer""" + str(2 + (i*2)) + """.org1.example.com:7051
      - CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=composer_default
      - CORE_PEER_LOCALMSPID=Org1MSP
      - CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/peer/msp
      - CORE_LEDGER_STATE_STATEDATABASE=CouchDB
      - CORE_LEDGER_STATE_COUCHDBCONFIG_COUCHDBADDRESS=couchdb""" + str(2 + (i*2)) + """:5984
      - CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer""" + str(2 + (i*2)) + """.org1.example.com:7051
      - CORE_PEER_GOSSIP_BOOTSTRAP=peer""" + str(2 + (i*2)) + """.org1.example.com:7051
      - CORE_PEER_TLS_ENABLED=true
      - CORE_PEER_GOSSIP_USELEADERELECTION=true
      - CORE_PEER_GOSSIP_ORGLEADER=false
      - CORE_PEER_PROFILE_ENABLED=true
      - CORE_PEER_TLS_CERT_FILE=/etc/hyperledger/peer/tls/server.crt
      - CORE_PEER_TLS_KEY_FILE=/etc/hyperledger/peer/tls/server.key
      - CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/peer/tls/ca.crt
    working_dir: /opt/gopath/src/github.com/hyperledger/fabric
    command: peer node start
    ports:
      - 9051:7051
      - 9053:7053
    volumes:
        - /var/run/:/host/var/run/
        - ./:/etc/hyperledger/configtx
        - ./crypto-config/peerOrganizations/org1.example.com/peers/peer""" + str(2 + (i*2)) + """.org1.example.com/msp:/etc/hyperledger/peer/msp
        - ./crypto-config/peerOrganizations/org1.example.com/peers/peer""" + str(2 + (i*2)) + """.org1.example.com/tls:/etc/hyperledger/peer/tls
        - ./crypto-config/peerOrganizations/org1.example.com/users:/etc/hyperledger/msp/users
        - ./crypto-config/ordererOrganizations/example.com/orderers/orderer""" + str(i + 1) + """.example.com/msp:/etc/hyperledger/msp/orderer/msp
    depends_on:
      - couchdb""" + str(2 + (i*2)) + """

  couchdb""" + str(2 + (i*2)) + """:
    container_name: couchdb""" + str(2 + (i*2)) + """
    image: hyperledger/fabric-couchdb:$ARCH-0.4.6
    ports:
      - 7984:5984
    environment:
      DB_URL: http://localhost:7984/member_db

  peer""" + str(3 + (i*2)) + """.org1.example.com:
    container_name: peer""" + str(3 + (i*2)) + """.org1.example.com
    image: hyperledger/fabric-peer:1.2.0
    environment:
      - CORE_LOGGING_PEER=debug
      - CORE_CHAINCODE_LOGGING_LEVEL=DEBUG
      - CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock
      - CORE_PEER_ID=peer""" + str(3 + (i*2)) + """.org1.example.com
      - CORE_PEER_ADDRESS=peer""" + str(3 + (i*2)) + """.org1.example.com:7051
      - CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=composer_default
      - CORE_PEER_LOCALMSPID=Org1MSP
      - CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/peer/msp
      - CORE_LEDGER_STATE_STATEDATABASE=CouchDB
      - CORE_LEDGER_STATE_COUCHDBCONFIG_COUCHDBADDRESS=couchdb""" + str(3 + (i*2)) + """:5984
      - CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer""" + str(3 + (i*2)) + """.org1.example.com:7051
      - CORE_PEER_GOSSIP_BOOTSTRAP=peer""" + str(2 + (i*2)) + """.org1.example.com:7051
      - CORE_PEER_TLS_ENABLED=true
      - CORE_PEER_GOSSIP_USELEADERELECTION=true
      - CORE_PEER_GOSSIP_ORGLEADER=false
      - CORE_PEER_PROFILE_ENABLED=true
      - CORE_PEER_TLS_CERT_FILE=/etc/hyperledger/peer/tls/server.crt
      - CORE_PEER_TLS_KEY_FILE=/etc/hyperledger/peer/tls/server.key
      - CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/peer/tls/ca.crt
    working_dir: /opt/gopath/src/github.com/hyperledger/fabric
    command: peer node start
    ports:
      - 10051:7051
      - 10053:7053
    volumes:
        - /var/run/:/host/var/run/
        - ./:/etc/hyperledger/configtx
        - ./crypto-config/peerOrganizations/org1.example.com/peers/peer""" + str(3 + (i*2)) + """.org1.example.com/msp:/etc/hyperledger/peer/msp
        - ./crypto-config/peerOrganizations/org1.example.com/peers/peer""" + str(3 + (i*2)) + """.org1.example.com/tls:/etc/hyperledger/peer/tls
        - ./crypto-config/peerOrganizations/org1.example.com/users:/etc/hyperledger/msp/users
        - ./crypto-config/ordererOrganizations/example.com/orderers/orderer""" + str(i + 1) + """.example.com/msp:/etc/hyperledger/msp/orderer/msp
        - ./couchdb""" + str(i + 1) + """/data:/opt/couchdb/data
    depends_on:
      - couchdb""" + str(3 + (i*2)) + """

  couchdb""" + str(3 + (i*2)) + """:
    container_name: couchdb""" + str(3 + (i*2)) + """
    image: hyperledger/fabric-couchdb:$ARCH-0.4.6
    ports:
      - 8984:5984
    environment:
      DB_URL: http://localhost:8984/member_db

    """
    text_file = open("composer/docker-compose-peer" + str(i + 2) + ".yml", "w")
    text_file.write(file)
    text_file.close()


