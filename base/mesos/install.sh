#!/bin/bash

#=======================
# Install mesos
#=======================
rpm -Uvh http://repos.mesosphere.io/el/6/noarch/RPMS/mesosphere-el-repo-6-2.noarch.rpm
yum install -y mesos
yum clean all