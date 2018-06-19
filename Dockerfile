FROM nginx:alpine

ENV HTPASSWD='foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.' \
    FORWARD_PORT=80 \
    FORWARD_HOST=web \
    PROXY_READ_TIMEOUT=900

WORKDIR /opt

RUN apk add --no-cache gettext apache2-utils

COPY auth.conf auth.htpasswd launch.sh ./

CMD ["./launch.sh"]
