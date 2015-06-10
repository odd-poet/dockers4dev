#!/bin/bash 

#=======================
# Install utils
#=======================
yum install -y curl wget tar telnet 
yum clean all

#=======================
# Install JDK7
#=======================
wget --no-cookies \
	--no-check-certificate \
	--header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
	http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.rpm

rpm -ivh jdk-7u80-linux-x64.rpm
rm jdk-7u80-linux-x64.rpm

echo "# set JAVA_HOME"  >> ~/.bashrc 
echo "export JAVA_HOME=/usr/java/default" >> ~/.bashrc 
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc

rm $0

