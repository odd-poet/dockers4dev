#!/bin/bash 

curl -L http://download.go.cd/gocd-rpm/go-agent-15.1.0-1863.noarch.rpm -o go-agent-15.1.0-1863.noarch.rpm
rpm -i go-agent-15.1.0-1863.noarch.rpm
rm go-agent-15.1.0-1863.noarch.rpm

# install maven 
wget http://mirror.apache-kr.org/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz
tar xvzf apache-maven-3.3.3-bin.tar.gz
ln -s /apache-maven-3.3.3/bin/mvn /usr/bin/mvn
rm apache-maven-3.3.3-bin.tar.gz

# install git + ssh 
yum install -y git openssh-clients expect zip unzip
mkdir /var/go/.ssh 
mv id_rsa /var/go/.ssh/
mv id_rsa.pub /var/go/.ssh/
chmod 700 /var/go/.ssh
chmod 600 /var/go/.ssh/id_rsa
chmod 644 /var/go/.ssh/id_rsa.pub
chown go:go -R /var/go/.ssh

# install scala
curl -L http://downloads.typesafe.com/scala/2.11.6/scala-2.11.6.tgz?_ga=1.239306691.1521285708.1433902192 -o scala-2.11.6.tgz
tar xvzf scala-2.11.6.tgz
curl -L http://downloads.typesafe.com/typesafe-activator/1.3.4/typesafe-activator-1.3.4.zip?_ga=1.162179068.1521285708.1433902192 -o typesafe-activator-1.3.4.zip
unzip typesafe-activator-1.3.4.zip
curl -L https://dl.bintray.com/sbt/native-packages/sbt/0.13.8/sbt-0.13.8.tgz -o sbt-0.13.8.tgz
tar xvzf sbt-0.13.8.tgz

# file permission 문제 fix 
# 기존 이미지에서는 아래와 같이 직접 수정함. 
# for d in $(docker ps | grep "Builder" | awk '{print $1}');do docker exec $d chmod +x activator-1.3.4/activator; echo $d; done;
chmod +x activator-1.3.4/activator


echo "# set SCALA"  >> ~/.bashrc 
echo "export SCALA_HOME=/scala-2.11.6" >> ~/.bashrc 
echo "export PATH=\$PATH:\$SCALA_HOME/bin:/activator-1.3.4:/sbt/bin" >> ~/.bashrc

# set javahome
echo "JAVA_HOME=/usr/java/default" >> /etc/default/go-agent
echo "export JAVA_HOME" >> /etc/default/go-agent
echo "export SCALA_HOME=/scala-2.11.6" >> /etc/default/go-agent
echo "export PATH=\$PATH:\$SCALA_HOME/bin:/activator-1.3.4:/sbt/bin" >> /etc/default/go-agent

# ignore host key checking
echo "Host *" >> /var/go/.ssh/config
echo "    StrictHostKeyChecking no" >> /var/go/.ssh/config
echo "    UserKnownHostsFile=/dev/null" >> /var/go/.ssh/config
chown go:go -R /var/go/.ssh

rm $0

# echo scala version 
source ~/.bashrc
scala -version 

