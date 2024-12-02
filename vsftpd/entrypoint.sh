#!/bin/bash
set -e

function ssl_tls_configuration () {
	local STC__USESSL="$USESSL"
	local STC__SSL_CERTIFICATE="$SSL_CERTIFICATE"
	local STC__FORCESSL="$FORCESSL"
	local STC__HOSTNAME="$HOSTNAME"
	local STC__VSFTPDDIR="$VSFTPDDIR"
	local STC__PRIVATEKEY_FILE="/etc/ssl/private/vsftpd.key"
	local STC__CERTIFICATE_FILE="/etc/ssl/certs/vsftpd.crt"
	local STC__CSR_FILE="/etc/ssl/certs/vsftpd.csr"

	if [ "$STC__USESSL" == "true" ]; then
		{
			echo "ssl_enable=YES"
			echo "allow_anon_ssl=NO"
			echo "ssl_tlsv1=NO"
			echo "ssl_sslv2=NO"
			echo "ssl_sslv3=NO"
			echo "rsa_cert_file=$STC__CERTIFICATE_FILE"
			echo "rsa_private_key_file=$STC__PRIVATEKEY_FILE"
		} >> "${STC__VSFTPDDIR}/vsftpd.conf"

		if [ "$STC__SSL_CERTIFICATE" == "false" ]; then
			openssl genrsa -out "$STC__PRIVATEKEY_FILE" 4096 &> /dev/null && echo "Private key generate [ OK ]" || exit 2
			openssl req -subj "/CN=$STC__HOSTNAME/C=ES/ST=Catalunya/L=Barcelona/O=Arroyof Solutions/OU=Sistemas/emailAddress=enzo@arroyof.com" \
			 -sha256 -new -key "$STC__PRIVATEKEY_FILE" -out "$STC__CSR_FILE" &> /dev/null && echo "CSR generate [ OK ]" || exit 2
			openssl x509 -req -days 365 -in "$STC__CSR_FILE" -signkey "$STC__PRIVATEKEY_FILE" -sha256 -out "$STC__CERTIFICATE_FILE" &> /dev/null && \
			 echo "Self-signed certificate generate [ OK ]" || exit 2
		fi

		if [ "$STC__FORCESSL" == "false" ]; then
			{
				echo "force_local_logins_ssl=NO"
				echo "force_local_data_ssl=NO"
			} >> "${STC__VSFTPDDIR}/vsftpd.conf"
		fi
		echo "SSL/ TLS configuration [ OK ]"
	else
		echo "SSL/ TLS configuration [ Not apply ]"
	fi
}

function general_coniguration () {
	local GC__VSFTPDDIR="$VSFTPDDIR"
	local GC__PASV_ADDRESS="$PASV_ADDRESS"
	local GC__FTP_SERVER_NAME="$FTP_SERVER_NAME"
	local GC__PASV_PROMISCUOUS="$PASV_PROMISCUOUS"
	local GC__PASV_MIN_PORT="$PASV_MIN_PORT"
	local GC__PASV_MAX_PORT="$PASV_MAX_PORT"

	sed -i "s/PASV_ADDRESS_TEMPLATE/$GC__PASV_ADDRESS/g" "${GC__VSFTPDDIR}/vsftpd.conf"
	sed -i "s/FTP_SERVER_NAME_TEMPLATE/$GC__FTP_SERVER_NAME/g" "${GC__VSFTPDDIR}/vsftpd.conf"

	if [ "$GC__PASV_PROMISCUOUS" == "true" ]; then
		echo "pasv_promiscuous=YES" >> "${GC__VSFTPDDIR}/vsftpd.conf"
	fi

	{
		echo "pasv_min_port=$GC__PASV_MIN_PORT"
		echo "pasv_max_port=$GC__PASV_MAX_PORT"
	} >> "${GC__VSFTPDDIR}/vsftpd.conf"

	echo "General configuration [ OK ]"
}


if [ "$1" = "vsftpd" ]; then
	VSFTPDDIR="/etc"
	PIDDIR="/var/run/vsftpd"
	LOGDIR="/var/log/vsftpd"
	SECURECHROOTDIR="/var/run/vsftpd/empty"

	if [ -z "$FTP_SERVER_NAME" ]; then
		export FTP_SERVER_NAME="Welcome to my FTP service"
	fi

	if [ -z "$PASV_ADDRESS" ]; then
		PASV_ADDRESS="$(tail -n 1 /etc/hosts | awk '{print $1}')"
		export PASV_ADDRESS
	fi

	if [ -z "$PASV_PROMISCUOUS" ]; then
		export PASV_PROMISCUOUS="false"
	fi

	if [ -z "$PASV_MIN_PORT" ]; then
		export PASV_MIN_PORT="4559"
	fi

	if [ -z "$PASV_MAX_PORT" ]; then
		export PASV_MAX_PORT="4564"
	fi

	if [ -z "$USESSL" ]; then
		export USESSL="false"
	fi

	if [ -z "$SSL_CERTIFICATE" ]; then
		export SSL_CERTIFICATE="false"
	fi

	if [ -z "$FORCESSL" ]; then
		export FORCESSL="false"
	fi

	# Neccesary directories creation
	mkdir -vp "$LOGDIR" "$PIDDIR" "$SECURECHROOTDIR"

	# VSFTPd log file creation
	touch "${LOGDIR}"/vsftpd.log
	touch "${LOGDIR}"/xferlog.log
	touch "${VSFTPDDIR}/vsftpd.user_list"

	# General configuration
	general_coniguration

	# SSL/TLS configuration
	ssl_tls_configuration

	# VSFTPd standard log container redirection
	tail -f "${LOGDIR}"/vsftpd.log | tee /dev/stdout &
	tail -f "${LOGDIR}"/xferlog.log | tee /dev/stdout &

cat << EOB

********************************
*                              *
*    Docker image: vsftpd      *
*                              *
********************************

SERVER SETTINGS
---------------
· FTP host: $PASV_ADDRESS
· Promiscuous: $PASV_PROMISCUOUS
· SSL enabled: $USESSL
· SSL forced: $FORCESSL
· SSL customized: $SSL_CERTIFICATE
---------------

EOB

"$@" "${VSFTPDDIR}/vsftpd.conf" &
pid="${!}"
wait "${pid}"
fi
