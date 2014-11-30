#!/bin/bash -e

#=======================
# Compile & install
#=======================
wget http://apache.mirror.cdnetworks.com/storm/apache-storm-${STORM_VERSION}-incubating/apache-storm-${STORM_VERSION}-incubating.tar.gz
tar xvzf apache-storm-${STORM_VERSION}-incubating.tar.gz
ln -s apache-storm-${STORM_VERSION}-incubating storm

#=======================
# Clean
#=======================
rm apache-storm-${STORM_VERSION}-incubating.tar.gz
rm $0
