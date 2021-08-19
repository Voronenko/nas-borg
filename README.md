# nas-borg


```sh

borg init --encryption=SPECIFY ssh://borg@127.0.0.1:2200/repository

```

```sh
borg create --stats ssh://borg@127.0.0.1:2200//repository::{hostname}-{utcnow}  ~/documents ~/files
```


## Credits

Original version was heavily inspired for home nas usage from  https://github.com/fphammerle/docker-borgbackup-sshd.
All original credits to author.
