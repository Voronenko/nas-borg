FROM docker.io/alpine:3.14.1

ARG BORGBACKUP_PACKAGE_VERSION=1.1.16-r1
ARG OPENSSH_SERVER_PACKAGE_VERSION=8.6_p1-r2
ARG TINI_PACKAGE_VERSION=0.19.0-r0
ARG USER=borg
ENV SSHD_HOST_KEYS_DIR=/etc/ssh/host_keys
ENV REPO_PATH=/repository
RUN apk add --no-cache \
        borgbackup="$BORGBACKUP_PACKAGE_VERSION" \
        openssh-server="$OPENSSH_SERVER_PACKAGE_VERSION" \
        tini=$TINI_PACKAGE_VERSION \
    && adduser -S -s /bin/ash "$USER" \
    && mkdir "$SSHD_HOST_KEYS_DIR" \
    && chown -c "$USER" "$SSHD_HOST_KEYS_DIR" \
    && mkdir "$REPO_PATH" \
    && chown -c "$USER" "$REPO_PATH"
VOLUME $SSHD_HOST_KEYS_DIR
VOLUME $REPO_PATH

COPY files/sshd_config /etc/ssh/sshd_config
EXPOSE 2200/tcp

ENV SSH_CLIENT_PUBLIC_KEYS=
ENV SSH_CLIENT_PUBLIC_KEYS_APPEND_ONLY=
COPY files/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

USER $USER
CMD ["/usr/sbin/sshd", "-D", "-e"]

# https://github.com/opencontainers/image-spec/blob/v1.0.1/annotations.md
ARG REVISION=
LABEL org.opencontainers.image.title="nas-borg" \
    org.opencontainers.image.source="https://github.com/voronenko/nas-borg" \
    org.opencontainers.image.revision="$REVISION"
