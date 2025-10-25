FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y netcat-openbsd vsftpd openssh-server ssh vim

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY entrypoint.sh /var/tmp/
COPY vsftpd.conf /etc/vsftpd.conf
COPY container_key.pub /home/root/.ssh/authorized_keys/

RUN useradd -m -s /bin/bash ftpuser
RUN echo "ftpuser:password" | chpasswd

RUN useradd -m -s /bin/bash seller01
RUN echo "seller01:seller01" | chpasswd

RUN chmod +x /var/tmp/entrypoint.sh

ENTRYPOINT service ssh start && /var/tmp/entrypoint.sh vsftpd
