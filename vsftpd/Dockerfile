FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y netcat-openbsd vsftpd openssh-server ssh vim

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY entrypoint.sh /var/tmp/
COPY vsftpd.conf /etc/vsftpd.conf
COPY container_key.pub /home/root/.ssh/authorized_keys/

RUN useradd -m -s /bin/bash ftpuser
RUN echo "ftpuser:password" | chpasswd

RUN chmod +x /var/tmp/entrypoint.sh

EXPOSE 20/tcp 21/tcp 22/tcp
EXPOSE 4559/tcp 4560/tcp 4561/tcp 4562/tcp 4563/tcp 4564/tcp

ENTRYPOINT service ssh start && /var/tmp/entrypoint.sh vsftpd
