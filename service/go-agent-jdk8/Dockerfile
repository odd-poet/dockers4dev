FROM oddpoet/centos6-jdk8
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/go-agent-jdk8
ENV DOCKER_IMAGE_TAG 14.3.0-1186


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