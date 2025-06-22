#!/bin/bash

clear

if [ "$(id -u)" == 0 ]; then
   echo "you are in root account..."
   read -p "enter user name :: " user
   if id "$username" &>/dev/null; then
       echo "$username already exists."
   else
       useradd -m "$user"
       echo "user : $user created successfully"
   fi
else
   echo "you should in root privilege...!!"
fi
