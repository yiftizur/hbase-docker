FROM java:8-jdk-alpine

RUN apk add --no-cache wget
RUN apk add --no-cache bash

RUN mkdir /opt
RUN wget -q http://archive.apache.org/dist/hbase/1.2.4/hbase-1.2.4-bin.tar.gz -O /opt/hbase-1.2.4-bin.tar.gz && cd /opt && tar xfvz hbase-1.2.4-bin.tar.gz && rm hbase-1.2.4-bin.tar.gz
RUN ln -s /opt/hbase-1.2.4 /opt/hbase
RUN /opt/hbase/bin/hbase-config.sh

ADD hbase-site.xml /opt/hbase/conf/hbase-site.xml
ADD start-hbase.sh /opt/hbase/bin/start-hbase.sh

# HBase Master API port
EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030

WORKDIR /opt/hbase/bin

ENV PATH=$PATH:/opt/hbase/bin

CMD /opt/hbase/bin/start-hbase.sh
