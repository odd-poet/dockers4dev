FROM oddpoet/centos6-jdk7
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/go-agent-jdk7
ENV DOCKER_IMAGE_TAG 15.1.0-1863
ENV SCALA_VERSION 2.11.6

#=======================
# Install
#=======================
COPY sshkey/id_rsa id_rsa
COPY sshkey/id_rsa.pub id_rsa.pub

COPY install.sh install.sh
RUN bash install.sh

#=======================
# Entrypoint
#=======================
COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]