# nas-borg


```sh

borg init --encryption=SPECIFY ssh://borg@127.0.0.1:2200/repository/NAME

```

```sh
borg create --stats ssh://borg@127.0.0.1:2200/repository/NAME::{hostname}-{utcnow}  ~/documents ~/files
```

## Regular backups

Consider using raw borg executable, some wrapper like borgmatic (see `borgmatic-example`), or even UI, like vorta


## Credits

Original version was heavily inspired for home nas usage from  https://github.com/fphammerle/docker-borgbackup-sshd.
All original credits to author.
