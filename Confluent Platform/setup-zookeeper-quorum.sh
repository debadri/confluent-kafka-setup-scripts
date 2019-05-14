#!/bin/bash
## create data dictionary for zookeeper
sudo mkdir -p /var/lib/data/zookeeper
sudo chown -R confluent:confluent /var/lib/data/

## Add hosts entries (mocking DNS) - put relevant IPs here
echo "10.132.1.2 confluent-platform-zk-cluster-node1
10.132.1.3 confluent-platform-zk-cluster-node2
10.132.1.4 confluent-platform-zk-cluster-node3
10.132.1.5 confluent-platform-broker-cluster-node1
10.132.1.6 confluent-platform-broker-cluster-node2
10.132.1.7 confluent-platform-broker-cluster-node3" | sudo tee --append /etc/hosts


## declare the server's identity  (ID SHOULD BE DIFFERENT PER NODE)
echo "1" > /var/lib/data/zookeeper/myid

# Navigate to zookeeper settings
vi /opt/confluent-5.2.1/etc/kafka/zookeeper.properties

## edit the zookeeper settings
ticktime=2000
dataDir=/var/lib/data/zookeeper
# the port at which the clients will connect
clientPort=2181
initLimit=5
syncLimit=2
server.1=confluent-platform-zk-cluster-node1:2888:3888
server.2=confluent-platform-zk-cluster-node2:2888:3888
server.3=confluent-platform-zk-cluster-node3:2888:3888
autopurge.snapRetainCount=3
autopurge.purgeInterval=24

## start the zookeeper
nohup /opt/confluent-5.2.1/bin/zookeeper-server-start /opt/confluent-5.2.1/etc/kafka/zookeeper.properties &

## stop the zookeeper
#nohup /opt/confluent-5.2.1/bin/zookeeper-server-stop &

## Test connectivity to local zookeeper using nc
ncat -vt localhost 2181

## Checking leader /follower in zookeeper
echo stat | nc confluent-platform-zk-cluster-node1 2181










