FROM ubuntu:20.04

RUN apt-get update && apt-get install -y curl python3 python3-pip libc6-i386 
RUN pip3 install requests

COPY ./download.py /var/activemq/download.py

WORKDIR /var/activemq

RUN python3 /var/activemq/download.py

RUN tar -xvz -f ./activemq.tar.gz
RUN rm ./activemq.tar.gz

RUN tar -xvz -f ./jre.tar.gz
RUN rm ./jre.tar.gz

COPY ./rename.py /var/activemq/rename.py

RUN python3 /var/activemq/rename.py

RUN mv jdk /opt/jve/

ENV JAVA_HOME="/opt/jve"
ENV PATH="${PATH}:${JAVA_HOME}/bin"

WORKDIR /var/activemq/activemq/conf

RUN sed -i 's/127.0.0.1/0.0.0.0/g' jetty.xml

WORKDIR /var/activemq/activemq/bin/

ENTRYPOINT ["./activemq", "console"]
