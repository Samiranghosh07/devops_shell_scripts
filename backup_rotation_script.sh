#!/bin/bash

backup_dir="/root/dbbackup/"
max_backups=5

while [ $(ls -l "$backup_dir" | wc -l) -gt "$max_backups" ]; do
	oldest_backup=$(ls -lt "$backup_dir" |tail -n 1)
	rm -r "$backup_dir/$oldest_backup"
done

echo "Backup rotation completed."
