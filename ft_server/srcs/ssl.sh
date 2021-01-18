#!/bin/bash

openssl req -x509 -nodes -sha256 -newkey rsa:2048 \
	-subj '/CN=localhost' \
	-keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt
