#!/bin/sh

rm /etc/nginx/conf.d/default.conf || :
envsubst < auth.conf > /etc/nginx/conf.d/auth.conf
htpasswd -bc /etc/nginx/auth.htpasswd $BASIC_USERNAME $BASIC_PASSWORD

exec nginx -g "daemon off;"
