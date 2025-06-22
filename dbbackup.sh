#!/bin/bash

clear

backup_path="/root/dbbackup/db.sql"
echo "welcome To database backup script"
echo ""

if [ "$(id -u)" == 0 ];then
   echo "you are in root account"
   read -p "enter database name :: " dbname
   echo ""
   read -p "enter database server/hostname :: " hostname
   echo ""
   read -p "enter database username :: " user
   echo ""
   mysqldump -h "$hostname" -u "$user" -p "$dbname" > "$backup_path"
   echo "!! db backup successfully competed !!"
   mysql -h "$hostname" -u "$user" -p "$dbname" < "$backup_path"
   echo "!! db backup has successfully restored !!"
else
   echo "not root"
   exit 1
fi


