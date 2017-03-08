
# Pull base image  
FROM centos:latest
  
MAINTAINER crabdave "calorie.david@gmail.com"  

# Usage: USER [UID]
USER root

# modify timezone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN yum -y install gcc make tcl systcl

ADD redis-3.2.5.tar.gz /opt

RUN cd /opt/redis-3.2.5 && make PREFIX=/usr/local/redis install

#RUN set -e
#RUN sysctl -w net.core.somaxconn=1024 >/dev/null 2>&1
#RUN sysctl -w vm.overcommit_memory=1 >/dev/null 2>&1
#RUN echo never > /sys/kernel/mm/transparent_hugepage/enabled
#RUN echo never > /sys/kernel/mm/transparent_hugepage/defrag

ADD redis.conf /opt/redis-3.2.5

#start
ENTRYPOINT ["/opt/redis-3.2.5/src/redis-server","/opt/redis-3.2.5/redis.conf"]


