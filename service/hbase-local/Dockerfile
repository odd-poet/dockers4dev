
FROM oddpoet/hbase-local-base:cdh5.2
MAINTAINER yunsang.choi <oddpoet@gmail.com>

#=======================
# ENV
#=======================
ENV DOCKER_IMAGE_NAME oddpoet/hbase-local
ENV DOCKER_IMAGE_TAG cdh5.2
ENV CDH_VER 5.2.0

#=======================
# Setup
#=======================
COPY core-site.xml /etc/hadoop/conf/core-site.xml
COPY hbase-site.xml /etc/hbase/conf/hbase-site.xml
COPY setup.sh setup.sh 
RUN /bin/bash setup.sh

#=======================
# Start services.
#=======================
COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]
