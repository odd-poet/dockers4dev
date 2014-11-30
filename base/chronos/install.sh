#!/bin/bash 

#=======================
# Install chronos
#=======================
cd /
curl -sSfL http://downloads.mesosphere.io/chronos/chronos-2.1.0_mesos-0.14.0-rc4.tgz --output chronos.tgz
tar xzf chronos.tgz

#=======================
# Clean
#=======================
rm chronos.tgz
rm $0