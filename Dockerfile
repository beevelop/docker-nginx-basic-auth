FROM nginx:alpine

ENV HTPASSWD='foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.' \
    FORWARD_PORT=80 \
    FORWARD_HOST=web

WORKDIR /opt

RUN apk add --no-cache gettext

COPY auth.conf healthcheck.conf auth.htpasswd launch.sh ./

HEALTHCHECK CMD wget -q http://localhost:80/ || exit 1

CMD ["./launch.sh"]
