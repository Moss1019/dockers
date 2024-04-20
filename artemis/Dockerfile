FROM ubuntu as downloader

COPY download.py /var/activemq/download.py

RUN apt-get update
RUN apt-get install -y python3 python3-pip

RUN pip3 install requests

WORKDIR /var/activemq

RUN python3 download.py
RUN tar -xf activemq-ar.tar.gz
RUN rm download.py activemq-ar.tar.gz
RUN mv ./* activemq-ar

FROM eclipse-temurin:19.0.2_7-jre-jammy

COPY --from=downloader /var/activemq /var/activemq

WORKDIR /var/activemq/activemq-ar/bin

RUN ./artemis create artemis-broker --user=admin --password=admin --allow-anonymous --http-host 0.0.0.0 --relax-jolokia

ENTRYPOINT ["/var/activemq/activemq-ar/bin/artemis-broker/bin/artemis", "run"]
