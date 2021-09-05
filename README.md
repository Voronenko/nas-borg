# nas-borg

## Configuring your repos on a serverside

Create authorized_keys file under config/. You should provide repository name with optional additional relative path,
referred as REPO_NAME below  and provide the public key to use - YOURKEY.

```sh
cat config/authorized_keys 
# command="mkdir -p ${REPO_PATH}/REPO_NAME && cd ${REPO_PATH}/REPO_NAME && borg serve --restrict-to-path ${REPO_PATH}/REPO_NAME ",restrict YOURKEY
```


```sh

borg init --encryption=SPECIFY ssh://borg@127.0.0.1:2200/repository/REPO_NAME

```

```sh
borg create --stats ssh://borg@127.0.0.1:2200/repository/REPO_NAME::{hostname}-{utcnow}  ~/documents ~/files
```

## Regular backups

Consider using raw borg executable, some wrapper like borgmatic (see `borgmatic-example`), or even UI, like vorta


## Credits

Original version was heavily inspired for home nas usage from  https://github.com/fphammerle/docker-borgbackup-sshd.
All original credits to author.
