#!/bin/sh

set -eu

# sync with https://github.com/fphammerle/docker-gitolite/blob/master/entrypoint.sh
if [ ! -f "$SSHD_HOST_KEYS_DIR/rsa" ]; then
    ssh-keygen -t rsa -b 4096 -N '' -f "$SSHD_HOST_KEYS_DIR/rsa"
fi
if [ ! -f "$SSHD_HOST_KEYS_DIR/ed25519" ]; then
    ssh-keygen -t ed25519 -N '' -f "$SSHD_HOST_KEYS_DIR/ed25519"
fi
unset SSHD_HOST_KEYS_DIR

# -- restrict-to-path 	restricts repository access to PATH. Can be specified multiple times to allow the client access
# to several directories. Access to all sub-directories is granted implicitly; PATH doesn’t need to directly point to a repository.

#	--restrict-to-repository	restrict repository access. Only the repository located at PATH (no sub-directories
# are considered) is accessible. Can be specified multiple times to allow the client access to several repositories.
# Unlike --restrict-to-path sub-directories are not accessible; PATH needs to directly point at a repository location.
# PATH may be an empty directory or the last element of PATH may not exist, in which case the client may initialize a repository there

authorize_key() {
    if echo -E "$1" | grep -q '^[a-z]'; then
        echo whoami
        mkdir -p ~/.ssh
        echo "command=\"/usr/bin/borg serve --restrict-to-path '$REPO_PATH'$2\" $1" >> ~/.ssh/authorized_keys
    fi
}
printenv SSH_CLIENT_PUBLIC_KEYS | while IFS=$'\n' read -r key; do
    authorize_key "$key" ""
done
unset SSH_CLIENT_PUBLIC_KEYS
# https://borgbackup.readthedocs.io/en/stable/usage/notes.html#append-only-mode
printenv SSH_CLIENT_PUBLIC_KEYS_APPEND_ONLY | while IFS=$'\n' read -r key; do
    authorize_key "$key" " --append-only"
done
unset SSH_CLIENT_PUBLIC_KEYS_APPEND_ONLY
unset REPO_PATH

set -x

exec "$@"
