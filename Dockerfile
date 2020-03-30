FROM nginx:alpine

ARG BUILD_DATE
ARG BUILD_VERSION
ARG VCS_REF

LABEL maintainer="Maik Hummel <hi@beevelop.com>" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$BUILD_VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vcs-url="https://github.com/beevelop/docker-nginx-basic-auth.git" \
      org.label-schema.name="beevelop/nginx-basic-auth" \
      org.label-schema.vendor="Maik Hummel (beevelop)" \
      org.label-schema.description="Simple Docker image for basic authentication" \
      org.label-schema.url="https://beevelop.com/" \
      org.label-schema.license="MIT" \
      org.opencontainers.image.title="beevelop/nginx-basic-auth" \
      org.opencontainers.image.description="Simple Docker image for basic authentication" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.authors="Maik Hummel (beevelop)" \
      org.opencontainers.image.vendor="Maik Hummel (beevelop)" \
      org.opencontainers.image.url="https://github.com/beevelop/docker-nginx-basic-auth" \
      org.opencontainers.image.documentation="https://github.com/beevelop/docker-nginx-basic-auth/blob/master/README.md" \
      org.opencontainers.image.source="https://github.com/beevelop/docker-nginx-basic-auth.git"

ENV HTPASSWD='foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.' \
    FORWARD_PORT=80 \
    FORWARD_HOST=web

WORKDIR /opt

RUN apk add --no-cache gettext

COPY auth.conf auth.htpasswd launch.sh ./

# make sure root login is disabled
RUN sed -i -e 's/^root::/root:!:/' /etc/shadow

CMD ["./launch.sh"]
