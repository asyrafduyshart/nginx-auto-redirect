#!/bin/bash

if [ ! -e "/etc/nginx/certs/cert.pem" ] || [ ! -e "/etc/nginx/certs/key.pem" ]
then
  openssl req -x509 -newkey rsa:2048 \
  -subj "/CN=localhost" \
  -keyout "/etc/nginx/certs/key.pem" \
  -out "/etc/nginx/certs/cert.pem" \
  -days 3650 -nodes -sha256
fi

envsubst '${VERIFICATION_FILE_NAME} ${MOBILE_URL} ${DESKTOP_URL} ${SERVER_NAMES}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

exec "$@"