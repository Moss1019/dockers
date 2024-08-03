FROM ubuntu

COPY download.py /var/activemq/download.py

RUN apt-get update
RUN apt-get install openjdk-11-jdk python3 python3-pip -y

RUN export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

RUN pip3 install requests --break-system-packages

WORKDIR /var/activemq

RUN python3 download.py
RUN tar -xf activemq-ar.tar.gz
RUN rm download.py activemq-ar.tar.gz
RUN mv ./* activemq-ar
WORKDIR /var/activemq/activemq-ar/bin

RUN ./artemis create mybroker --user=admin --password=admin --allow-anonymous --http-host 0.0.0.0 --relax-jolokia
RUN /var/activemq/activemq-ar/bin/mybroker/bin/artemis-service start

ENTRYPOINT ["/var/activemq/activemq-ar/bin/mybroker/bin/artemis", "run"]
