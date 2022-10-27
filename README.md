![![Build Status](https://drone-pub.chris-tech.me/api/badges/chrisguoado/docker-nginx-basic-auth/status.svg)](https://drone-pub.chris-tech.me/chrisguoado/docker-nginx-basic-auth)

# nginx-basic-auth

---

> Simple Docker image to provide basic authentication for a single other container, or another process on the host.

## Quickstart

```bash
docker run -d --name web dockercloud/hello-world
docker run -d -p 80:80 --link web:web --name auth chrisguoado/nginx-basic-auth:1
```

Try accessing and logging in with username `foo` and password `bar`.

## Advanced
### For container:
```bash
docker run -d \
           -e HTPASSWD='foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.' \
           -e FORWARD_PORT=1337 \
           --link web:web -p 8080:80 \
           --name auth \
           chrisguoado/nginx-basic-auth:1
```

> Use single quotes to prevent unwanted interpretation of `$` signs!

### For process on the host:
```bash
docker run -d \
           -e HTPASSWD='foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.' \
           -e LISTEN_PORT=8888 \
           -e FORWARD_HOST=127.0.0.1 \
           -e FORWARD_PORT=1337 \
           --name auth \
           chrisguoado/nginx-basic-auth:1
```
## Configuration

- `HTPASSWD` (default: `foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.`): Will be written to the .htpasswd file on launch (non-persistent)
- `FORWARD_PORT` (default: `80`): Port of the **source** container that should be forwarded
- `FORWARD_HOST` (default: `web`): Hostname of the **source** container that should be forwarded
  > The container does not need any volumes to be mounted! Nonetheless you will find all interesting files at `/etc/nginx/*`.

## Multiple Users

Multiple Users are possible by separating the users by newline. To pass the newlines properly you need to use Shell Quoting (like `$'foo\nbar'`):

```
docker run -d --link web:web --name auth \
           -e HTPASSWD=$'foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.\ntest:$apr1$LKkW8P4Y$P1X/r2YyaexhVL1LzZAQm.' \
           chrisguoado/nginx-basic-auth:1
```

results in 2 users (`foo:bar` and `test:test`).

## Troubleshooting

```
nginx: [emerg] host not found in upstream "web" in /etc/nginx/conf.d/auth.conf:80
```

- You need to link the container as `web` (`--link foobar:web`)

---

- SSL is unsupported ATM, but might be available in the near future. For now it might be a suitable solution to use another reverse proxy (e.g. `jwilder/nginx-proxy`) that acts as a central gateway. You just need to configure the `VIRTUAL_HOST` env and disable port forwarding.
