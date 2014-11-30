#!/bin/bash 

#=======================
# Install HBase
#=======================
yum install -y hadoop-conf-pseudo hbase hbase-master hbase-regionserver
yum clean all

