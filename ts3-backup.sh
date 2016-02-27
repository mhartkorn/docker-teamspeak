#!/bin/sh
# Only backup if teamspeak-data container exists
docker inspect teamspeak-data >/dev/null 2>&1 || {
  echo "teamspeak-data does not exist, skipping backup"
  exit 1
}

today=$(date +%Y%m%d-%H%M%S)
echo "Backing up to backup_${today}.tar.bz2..."
docker run -it --rm --volumes-from teamspeak-data --volume "$(pwd):/backup" teamspeak tar -acvf /backup/backup_${today}.tar.bz2 /data

