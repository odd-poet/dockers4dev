#!/bin/bash 

#=======================
# Add Repo
#=======================
curl http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/cloudera-cdh5.repo -o /etc/yum.repos.d/cloudera-cdh5.repo
sed -i "s|cdh/5/|cdh/${CDH_VER}/|" /etc/yum.repos.d/cloudera-cdh5.repo
yum clean all
