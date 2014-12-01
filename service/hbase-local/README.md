HBase (pseudo-distributed mode)
=================

- version: 0.98.6 (CDH 5.2)

Usage 
-------

You can see usage ``docker run oddpoet/hbase-local -h``. 

```
$ docker run oddpoet/hbase-local -h
###########################################################
        HBase (CHD-5.2.0) : pseudo-distributed mode
###########################################################

Usage: docker run DOCKER_OPTS oddpoet/hbase-local:cdh5.2 OPTIONS

Environment vars:
  --ZK_HOSTS=localhost                   hbase.zookeeper.quorum.
                                         If you use default value(localhost), local zookeeper-server will be run.
  --MASTER_PORT=60000                    hbase.master.port
  --MASTER_INFO_PORT=60010               hbase.master.info.port
  --REGIONSERVER_PORT=60000              hbase.regionserver.port
  --REGIONSERVER_INFO_PORT=60010         hbase.regionserver.info.port

Options:
  -h,  --help                            help message
  shell                                  execute shell. should run docker with '-i -t'. (service will not be started)

Example:
    docker run \
         -d -h hbase \
         -p 65000:65000 -p 65010:65010 \
         -p 65020:65020 -p 65030:65030 \
         -p 2181:2181 \
         -e MASTER_PORT=65000 \
         -e MASTER_INFO_PORT=65010 \
         -e REGIONSERVER_PORT=65020 \
         -e REGIONSERVER_INFO_PORT=65030 \
         oddpoet/hbase-local:cdh5.2
```

fig.yml
--------

```
hbase:
  image: oddpoet/hbase-local
  hostname: hbase.box
  environment:
    - ZK_HOSTS=zk-server:2181
  ports:
    - "60000:60000"
    - "60010:60010"
    - "60020:60020"
    - "60030:60030"
  links:
    - "zookeeper:zk-server"
zookeeper:
  image: oddpoet/zookeeper
  ports:
    - "2181:2181"
```
