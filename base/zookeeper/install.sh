#!/bin/bash 
rm $0
#=======================
# Install zookeeper
#=======================
yum install -y zookeeper-server
yum clean all

#=======================
# Setup zookeeper
#=======================
mkdir -p /var/lib/zookeeper
chown -R zookeeper /var/lib/zookeeper/
service zookeeper-server init