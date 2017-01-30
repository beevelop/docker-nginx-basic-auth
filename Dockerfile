FROM nginx:alpine

ENV HTPASSWD='foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.' \
    FORWARD_PORT=80 \
    FORWARD_HOST=web \
    AUTHENTICATED=true

WORKDIR /opt

RUN apk add --no-cache gettext

COPY without-auth.conf with-auth.conf with-auth.htpasswd launch.sh ./

CMD ["./launch.sh"]
