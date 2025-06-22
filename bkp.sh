#!/bin/bash

clear 

src="/root/shell_scripts"
dest="/root/backup"
date=$(date +%Y%m%d_%H%M%S)
host=$(hostname -s)
archive="$host"_"$date".tar.gz

tar -czvf "$dest"/"$archive" "$src"
echo "!! Backup completed successfully..!!"

gpg -c "$dest"/"$archive"
echo "!! Backup successfully encrypted !!"

