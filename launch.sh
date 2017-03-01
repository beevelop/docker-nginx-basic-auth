#!/bin/sh

rm /etc/nginx/conf.d/default.conf || :
envsubst < auth.conf > /etc/nginx/conf.d/auth.conf
envsubst < auth.htpasswd > /etc/nginx/auth.htpasswd

if [ -n "${DNS_RESOLVER}" ]; then
  echo "resolver ${DNS_RESOLVER};" >> /etc/nginx/conf.d/auth.conf
fi

nginx -g "daemon off;"
