#!/bin/bash 

curl -L http://download.go.cd/gocd-rpm/go-agent-14.3.0-1186.noarch.rpm -o go-agent-14.3.0-1186.noarch.rpm
rpm -i go-agent-14.3.0-1186.noarch.rpm
rm go-agent-14.3.0-1186.noarch.rpm

# install maven 
wget http://apache.tt.co.kr/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz
tar xvzf apache-maven-3.2.3-bin.tar.gz
ln -s /apache-maven-3.2.3/bin/mvn /usr/bin/mvn
rm apache-maven-3.2.3-bin.tar.gz

# install git + ssh 
yum install -y git openssh-clients expect
mkdir /var/go/.ssh 
mv id_rsa /var/go/.ssh/
mv id_rsa.pub /var/go/.ssh/
chmod 700 /var/go/.ssh
chmod 600 /var/go/.ssh/id_rsa
chmod 644 /var/go/.ssh/id_rsa.pub
chown go:go -R /var/go/.ssh

# set javahome
echo "JAVA_HOME=/usr/java/default" >> /etc/default/go-agent
echo "export JAVA_HOME" >> /etc/default/go-agent

# ignore host key checking
echo "Host *" >> /var/go/.ssh/config
echo "    StrictHostKeyChecking no" >> /var/go/.ssh/config
echo "    UserKnownHostsFile=/dev/null" >> /var/go/.ssh/config
chown go:go -R /var/go/.ssh

rm $0
