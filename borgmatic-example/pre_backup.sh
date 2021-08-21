#!/bin/sh

export DATABASE_URL=postgres://postgres:postgres@localhost:5432/postgres
export DATABASE_TARGET=/home/ubuntu/BACKUP/DATABASE
pg_dump $DATABASE_URL -f $DATABASE_TARGET/database.sql || - echo "[BACKUP ERROR] BORG " | /home/ubuntu/BACKUP/slacktee
date > /home/ubuntu/BACKUP/last_backuped.txt
