#!/bin/bash
threshold=90

cpu_usage=$(top | grep "Cpu(s)" | awk '{print $2}')

if [[ "$cpu_usage" -gt "$threshold" ]]; then
	echo "High CPU usage detected:$cpu_usage"
else
       echo "Low $cpu_usage"
fi
