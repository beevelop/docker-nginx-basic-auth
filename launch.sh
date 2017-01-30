#!/bin/sh

rm /etc/nginx/conf.d/default.conf || :

if [ "$AUTHENTICATED" = true ] ; then
	envsubst < with-auth.conf > /etc/nginx/conf.d/auth.conf
	envsubst < with-auth.htpasswd > /etc/nginx/auth.htpasswd
else
	envsubst < without-auth.conf > /etc/nginx/conf.d/auth.conf
fi

nginx -g "daemon off;"
