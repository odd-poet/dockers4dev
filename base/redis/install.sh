#!/bin/bash 

declare VERSION=$DOCKER_IMAGE_TAG
curpath=$(cd $(dirname $0); pwd)

# To reduce image size, I do yum install and undo. 
#=======================
# download & untar
#=======================
yum history new
yum install -y wget tar
wget http://download.redis.io/releases/redis-$VERSION.tar.gz
tar xvzf redis-$VERSION.tar.gz
yum history undo 1 -y


#=======================
# Compile & install
#=======================
yum history new
yum groupinstall -y 'Development Tools'
cd redis-$VERSION
make install
yum history undo 1 -y


#=======================
# Clean
#=======================
cd $curpath
rm -rf redis-$VERSION
rm redis-$VERSION.tar.gz
rm $0
