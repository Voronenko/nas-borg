## Installation:

```sh
sudo pip3 install --upgrade borgmatic borg
```

on older python distributions borg might cause conflicts.
Either update python to version, which has not reached EOL,
or install borg in binary form

```
curl -sLo /usr/local/bin/borg https://github.com/borgbackup/borg/releases/download/1.1.15/borg-linux64
chmod +x /usr/local/bin/borg
```

initialize cron

```sh
crontab -e
0 5 * * * PATH=$PATH:/usr/bin:/usr/local/bin /usr/local/bin/borgmatic --syslog-verbosity 1 --files --config /home/ubuntu/BACKUP/borgmatic.yaml
```


## Initialization of the client  backup:

Assuming, that address of the borg instance is 10.9.0.82

```sh
borg init backup@10.9.0.82:main --encryption SPECIFY
```

If you can't connect, ensure that security group for BorgBackup instance
allows SSH connections from the instance you want to backup


Validating backup works:

validate-borgmatic-config -c ~/BACKUP

Doing backup

borgmatic --verbosity 1 --files --config /home/ubuntu/BACKUP/borgmatic.yaml

Add to cron:

0 3 * * * root PATH=$PATH:/usr/bin:/usr/local/bin /usr/local/bin/borgmatic --syslog-verbosity 1 --files --config /home/ubuntu/BACKUP/borgmatic.yaml

Validating list of backups  borg list backup@10.9.0.82:main
