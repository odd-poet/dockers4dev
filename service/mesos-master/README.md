Mesos master
=================

- version: 0.21.0

Usage 
-------

You can see usage ``docker run oddpoet/mesos-master -h``. 

```
$ docker run oddpoet/mesos-master -h
###########################################################
         Mesos-Master 0.21.0
###########################################################

Usage: docker run DOCKER_OPTS oddpoet/mesos-master:0.21.0 OPTIONS

Environment vars:
  PORT=5050                          service port
  ZK_URL=zk://localhost:2181/mesos   zookeeper url.
                                     If you use default value, local zookeeper server will be start.

Options:
  -h,  --help                        help message
  shell                              execute shell. should run docker with '-i -t'. (service will not be started)

Example:
    docker run -d \
         -p 5050:5050 \
         -e PORT=5050 \
         -e ZK_URL=zk://zk-server1:2181,zk-server2:2181/mesos \
         oddpoet/mesos-master:0.21.0
```

fig.yml
--------

```
mesos0:
  image: oddpoet/mesos-master
  environment:
    - PORT=5050
    - ZK_URL=zk://zookeeper:2181/mesos
  ports:
    - "5050:5050"
  links:
    - zookeeper:zookeeper
mesos1:
  image: oddpoet/mesos-slave
  environment:
    - PORT=5051
    - ZK_URL=zk://zookeeper:2181/mesos
  ports:
    - "5051:5051"
  links:
    - zookeeper:zookeeper
mesos2:
  image: oddpoet/mesos-slave
  environment:
    - PORT=5052
    - ZK_URL=zk://zookeeper:2181/mesos
  ports:
    - "5052:5052"
  links:
    - zookeeper:zookeeper
zookeeper:
  image: oddpoet/zookeeper
  environment:
    - PORT=2181
  ports:
    - "2181:2181"
```
