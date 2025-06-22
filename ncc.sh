#!/bin/bash

clear

domain="www.google.com"
echo "Wait for Connectivity check................."

if ping -c 10 "$domain" &>/dev/null ; then
   echo "Network is up"
else
   echo "Network is down"
fi
