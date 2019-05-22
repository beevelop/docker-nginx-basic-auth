FROM nginx:alpine

ENV HTPASSWD='foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.' \
    FORWARD_PORT=80 \
    FORWARD_HOST=web

WORKDIR /opt

RUN apk add --no-cache gettext

COPY auth.conf auth.htpasswd launch.sh ./

# make sure root login is disabled
RUN sed -i -e 's/^root::/root:!:/' /etc/shadow

CMD ["./launch.sh"]
