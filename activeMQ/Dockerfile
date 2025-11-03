FROM archlinux AS downloader

# RUN apt-get update
# RUN apt-get install wget -y
RUN pacman -Sy wget --noconfirm

WORKDIR /var

RUN wget -O activemq.tar.gz https://dlcdn.apache.org//activemq/6.1.8/apache-activemq-6.1.8-bin.tar.gz
RUN tar -xf activemq.tar.gz
RUN rm activemq.tar.gz
RUN mv apache-activemq-6.1.8 activemq

FROM eclipse-temurin:19.0.2_7-jre-jammy

COPY --from=downloader /var/activemq /var/activemq

WORKDIR /var/activemq/conf

RUN sed -i 's/127.0.0.1/0.0.0.0/g' jetty.xml

WORKDIR /var/activemq/bin/

ENTRYPOINT ["./activemq", "console"]