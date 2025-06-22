#!/bin/bash

log_path="/var/log/auth.log"
grep "session closed" "$log_path" > /root/error_log_file.txt

echo "logfile created successfully!!"
