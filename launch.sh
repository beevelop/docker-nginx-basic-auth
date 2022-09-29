#!/bin/sh

rm /etc/nginx/conf.d/default.conf || :
envsubst < auth.conf > /etc/nginx/conf.d/auth.conf
envsubst < auth.htpasswd > /etc/nginx/auth.htpasswd

exec nginx -g "daemon off;"
