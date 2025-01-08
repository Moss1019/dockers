FROM debian:buster-slim

RUN apt-get update -y && \
	apt-get install -y openssl netcat vsftpd openssh-server ssh vim --no-install-recommends && \
	apt-get autoremove -y && apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

COPY vsftpd.conf /etc/vsftpd.conf

COPY entrypoint.sh /var/tmp/

# COPY container_key.pub /root/.ssh/authorized_keys/
# COPY container_host /etc/ssh/ssh_host_rsa_key
# COPY container_host.pub /etc/ssh/ssh_host_rsa_key.pub

RUN useradd -m -d /home/ftpuser ftpuser
RUN printf "password\npassword" | passwd ftpuser

RUN chmod +x /var/tmp/entrypoint.sh

# RUN sed 's/#PubkeyAuthentication/PubkeyAuthentication' /etc/ssh/sshd_config

EXPOSE 20/tcp 21/tcp 22/tcp
EXPOSE 4559/tcp 4560/tcp 4561/tcp 4562/tcp 4563/tcp 4564/tcp

ENTRYPOINT ["/var/tmp/entrypoint.sh"]
CMD ["vsftpd"]
