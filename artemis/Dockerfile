FROM ubuntu AS downloader

RUN apt-get update
RUN apt-get install wget -y

WORKDIR /var/activemq

RUN wget -O artemis.tar.gz https://dlcdn.apache.org/activemq/activemq-artemis/2.43.0/apache-artemis-2.43.0-bin.tar.gz
RUN tar -xf artemis.tar.gz
RUN rm artemis.tar.gz
RUN mv ./* activemq-ar

FROM eclipse-temurin:19.0.2_7-jre-jammy

COPY --from=downloader /var/activemq /var/activemq

WORKDIR /var/activemq/activemq-ar/bin

RUN ./artemis create artemis-broker --user=admin --password=admin --allow-anonymous --http-host 0.0.0.0 --relax-jolokia

ENTRYPOINT ["/var/activemq/activemq-ar/bin/artemis-broker/bin/artemis", "run"]
