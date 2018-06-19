#!/bin/sh

if [ "$RAW_CREDENTIALS" = 1 ]; then
  HTPASSWD=$(
    for line in $(echo $HTPASSWD); do
      USERNAME="$(echo "$line" | cut -d':' -f1)"
      PASSWORD="$(echo "$line" | cut -d':' -f2)"
      htpasswd -nb "$USERNAME" "$PASSWORD" | head -n1
    done
  )
fi

export NAMESERVER=$(cat /etc/resolv.conf | grep 'nameserver' | awk '{print $2}' | tr '\n' ' ')

rm /etc/nginx/conf.d/default.conf || :

envsubst '$NAMESERVER,$FORWARD_HOST,$FORWARD_PORT,$PROXY_READ_TIMEOUT' \
  < auth.conf > /etc/nginx/conf.d/auth.conf
envsubst < auth.htpasswd > /etc/nginx/auth.htpasswd

nginx -g "daemon off;"
