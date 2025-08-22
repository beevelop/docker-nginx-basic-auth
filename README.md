![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/beevelop/docker-nginx-basic-auth/docker.yml?style=for-the-badge)
![Docker Pulls](https://img.shields.io/docker/pulls/beevelop/nginx-basic-auth.svg?style=for-the-badge)
![Docker Stars](https://img.shields.io/docker/stars/beevelop/nginx-basic-auth?style=for-the-badge)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/beevelop/nginx-basic-auth/latest?style=for-the-badge)
![License](https://img.shields.io/github/license/beevelop/docker-nginx-basic-auth?style=for-the-badge)
[![GitHub release](https://img.shields.io/github/release/beevelop/docker-nginx-basic-auth.svg?style=for-the-badge)](https://github.com/beevelop/docker-nginx-basic-auth/releases)
![GitHub Release Date](https://img.shields.io/github/release-date/beevelop/docker-nginx-basic-auth?style=for-the-badge)
![CalVer](https://img.shields.io/badge/CalVer-YYYY.MM.MICRO-22bfda.svg?style=for-the-badge)
[![Beevelop](https://img.shields.io/badge/-%20Made%20with%20%F0%9F%8D%AF%20by%20%F0%9F%90%9Dvelop-blue.svg?style=for-the-badge)](https://beevelop.com)

# Docker Nginx Basic Auth - Simple Authentication Proxy

> Lightweight nginx reverse proxy with HTTP basic authentication for securing Docker containers and web applications.

## Quickstart

```bash
docker run -d --name web dockercloud/hello-world
docker run -d -p 80:80 --link web:web --name auth beevelop/nginx-basic-auth
```

Try accessing and logging in with username `foo` and password `bar`.

## Advanced

```bash
docker run -d \
           -e HTPASSWD='foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.' \
           -e FORWARD_PORT=1337 \
           --link web:web -p 8080:80 \
           --name auth \
           beevelop/nginx-basic-auth
```

> Use single quotes to prevent unwanted interpretation of `$` signs!

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
           beevelop/nginx-basic-auth
```

results in 2 users (`foo:bar` and `test:test`).

## Troubleshooting

**Error: `nginx: [emerg] host not found in upstream "web"`**
- Ensure you link the container as `web` using `--link foobar:web`

## Limitations

- SSL/HTTPS is not currently supported
- For SSL requirements, consider using `jwilder/nginx-proxy` as a central gateway with `VIRTUAL_HOST` environment variable

---

# All Docker Images

| Badge | Pulls | Build Status | Release Date | Release |
| --- | --- | --- | --- | --- |
| [![base](https://img.shields.io/badge/beevelop%2Fbase-grey?style=flat-square&logo=github)](https://github.com/beevelop/docker-base) | ![Docker Pulls](https://img.shields.io/docker/pulls/beevelop/base.svg?style=flat-square) | ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/beevelop/docker-base/docker.yml?style=flat-square) | ![GitHub Release Date](https://img.shields.io/github/release-date/beevelop/docker-base?style=flat-square) | ![GitHub release](https://img.shields.io/github/release/beevelop/docker-base.svg?style=flat-square) |
| [![java](https://img.shields.io/badge/beevelop%2Fjava-grey?style=flat-square&logo=github)](https://github.com/beevelop/docker-java) | ![Docker Pulls](https://img.shields.io/docker/pulls/beevelop/java.svg?style=flat-square) | ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/beevelop/docker-java/docker.yml?style=flat-square) | ![GitHub Release Date](https://img.shields.io/github/release-date/beevelop/docker-java?style=flat-square) | ![GitHub release](https://img.shields.io/github/release/beevelop/docker-java.svg?style=flat-square) |
| [![android](https://img.shields.io/badge/beevelop%2Fandroid-grey?style=flat-square&logo=github)](https://github.com/beevelop/docker-android) | ![Docker Pulls](https://img.shields.io/docker/pulls/beevelop/android.svg?style=flat-square) | ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/beevelop/docker-android/docker.yml?style=flat-square) | ![GitHub Release Date](https://img.shields.io/github/release-date/beevelop/docker-android?style=flat-square) | ![GitHub release](https://img.shields.io/github/release/beevelop/docker-android.svg?style=flat-square) |
| [![android-nodejs](https://img.shields.io/badge/beevelop%2Fandroid_nodejs-grey?style=flat-square&logo=github)](https://github.com/beevelop/docker-android-nodejs) | ![Docker Pulls](https://img.shields.io/docker/pulls/beevelop/android-nodejs.svg?style=flat-square) | ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/beevelop/docker-android-nodejs/docker.yml?style=flat-square) | ![GitHub Release Date](https://img.shields.io/github/release-date/beevelop/docker-android-nodejs?style=flat-square) | ![GitHub release](https://img.shields.io/github/release/beevelop/docker-android-nodejs.svg?style=flat-square) |
| [![cordova](https://img.shields.io/badge/beevelop%2Fcordova-grey?style=flat-square&logo=github)](https://github.com/beevelop/docker-cordova) | ![Docker Pulls](https://img.shields.io/docker/pulls/beevelop/cordova.svg?style=flat-square) | ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/beevelop/docker-cordova/docker.yml?style=flat-square) | ![GitHub Release Date](https://img.shields.io/github/release-date/beevelop/docker-cordova?style=flat-square) | ![GitHub release](https://img.shields.io/github/release/beevelop/docker-cordova.svg?style=flat-square) |
| [![ionic](https://img.shields.io/badge/beevelop%2Fionic-grey?style=flat-square&logo=github)](https://github.com/beevelop/docker-ionic) | ![Docker Pulls](https://img.shields.io/docker/pulls/beevelop/ionic.svg?style=flat-square) | ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/beevelop/docker-ionic/docker.yml?style=flat-square) | ![GitHub Release Date](https://img.shields.io/github/release-date/beevelop/docker-ionic?style=flat-square) | ![GitHub release](https://img.shields.io/github/release/beevelop/docker-ionic.svg?style=flat-square) |
| [![nginx-basic-auth](https://img.shields.io/badge/beevelop%2Fnginx_basic_auth-grey?style=flat-square&logo=github)](https://github.com/beevelop/docker-nginx-basic-auth) | ![Docker Pulls](https://img.shields.io/docker/pulls/beevelop/nginx-basic-auth.svg?style=flat-square) | ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/beevelop/docker-nginx-basic-auth/docker.yml?style=flat-square) | ![GitHub Release Date](https://img.shields.io/github/release-date/beevelop/docker-nginx-basic-auth?style=flat-square) | ![GitHub release](https://img.shields.io/github/release/beevelop/docker-nginx-basic-auth.svg?style=flat-square) |

---

![Beevelop's Docker Image Hierarchy](https://gist.githubusercontent.com/beevelop/b0cddab7209a683c77560d06ff00bc8e/raw/15429ee1d02e2c4dc019b760ca8c7ceff5911b82/hierarchy.png)

### Use tags where possible, because

![One does not simply use latest](https://i.imgflip.com/1fgwxr.jpg)
