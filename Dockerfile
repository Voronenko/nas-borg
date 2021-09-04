FROM docker.io/alpine:3.14.1

ARG BORGBACKUP_PACKAGE_VERSION=1.1.16-r1
ARG OPENSSH_SERVER_PACKAGE_VERSION=8.6_p1-r2
ARG USER=borg
ARG USERID=1000
ENV SSHD_HOST_KEYS_DIR=/etc/ssh/host_keys
ENV REPO_PATH=/repository

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

ADD files/install  /

RUN apk add --no-cache \
        borgbackup="$BORGBACKUP_PACKAGE_VERSION" \
        openssh-server="$OPENSSH_SERVER_PACKAGE_VERSION" \
        bash \
        curl \
    && adduser -u $USERID -S -s /bin/ash "$USER" \
    && mkdir "$SSHD_HOST_KEYS_DIR" \
    && chown -c "$USER" "$SSHD_HOST_KEYS_DIR" \
    && mkdir "$REPO_PATH" \
    && chown -c "$USER" "$REPO_PATH" \
    && curl -sLo /usr/local/bin/ep https://github.com/kreuzwerker/envplate/releases/download/v0.0.8/ep-linux \
    && chmod +x /usr/local/bin/ep

VOLUME $SSHD_HOST_KEYS_DIR
VOLUME $REPO_PATH

COPY files/sshd_config /etc/ssh/sshd_config
EXPOSE 2200/tcp

ENTRYPOINT ["/init"]


# https://github.com/opencontainers/image-spec/blob/v1.0.1/annotations.md
ARG REVISION=
LABEL org.opencontainers.image.title="nas-borg" \
    org.opencontainers.image.source="https://github.com/voronenko/nas-borg" \
    org.opencontainers.image.revision="$REVISION"
